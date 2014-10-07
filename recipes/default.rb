include_recipe "deploy"

node[:deploy].each do |application, deploy|
  node.override[:deploy][application][:deploy_to] = "/srv/www/#{application}/#{node[:"opsworks-migrations"][:dir]}"
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

  ruby_block "Running Bundle Install" do
    block do
      Chef::Log.info(OpsWorks::ShellOut.shellout("cd #{deploy[:deploy_to]}/current &&  bundle install --path #{deploy[:deploy_to]}/shared/bundle --without=test development --deployment"))
    end
  end

  ruby_block "Running Migrations" do
    block do
      migration_command = deploy[:migration_command] || node[:"opsworks-migrations"][:command]
      Chef::Log.info(OpsWorks::ShellOut.shellout("cd #{deploy[:deploy_to]}/current &&  RAILS_ENV=#{deploy[:rails_env]} #{migration_command}"))
    end
  end
end
