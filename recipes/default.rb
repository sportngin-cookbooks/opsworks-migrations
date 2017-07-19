helper = OpsworksMigrations::Helper.new(node)
include_recipe "deploy"

node[:deploy].each do |application, deploy|
  node.override[:deploy][application][:deploy_to] = "/srv/www/#{application}/#{helper.dir}"
  deploy = node[:deploy][application]
  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  Chef::Log.info("Ensuring shared/cache directory for #{application} app...")
  directory "#{deploy[:deploy_to]}/shared/cache" do
    group 'nginx'
    owner 'deploy'
    mode 0775
    action :create
    recursive true
  end

  Chef::Log.info("DEPLOY ATTRIBUTES: #{deploy.inspect}")
  opsworks_deploy do
    deploy_data deploy
    app application
  end

  ruby_block "Run Bundle Install" do
    block do
      bundle = Mixlib::ShellOut.new("#{node[:opsworks_migrations][:bundler_path]} install --path #{deploy[:deploy_to]}/shared/bundle --without=test development --deployment",
                                    :env => nil, :user => deploy[:user], :cwd => "#{deploy[:deploy_to]}/current", :live_stream => $stdout).run_command
      bundle.error!
    end
  end

  ruby_block "Running Migrations" do
    block do
      migration_command = deploy[:migration_command] || helper.command
      Chef::Log.info(
          helper.shellout(
              "cd #{deploy[:deploy_to]}/current && RAILS_ENV=#{deploy[:rails_env]} #{migration_command}",
              { :timeout => node[:opsworks_migrations][:timeout] }
          )
      )
    end
  end
end
