include_recipe "deploy"

node[:deploy].each do |application, deploy|
  node.override[:deploy][application][:deploy_to] = "/srv/www/#{application}/#{node[:"opsworks-migrations"][:dir]}"
  deploy = node[:deploy][application]
  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  ruby_block "Run Bundle Install" do
    block do
      Chef::Log.info(`cd #{deploy[:deploy_to]}/current &&  bundle install --path #{deploy[:deploy_to]}/shared/bundle --without=test development --deployment`)
      raise "Bundle Install FAILED" unless $?.success?
    end
  end

  ruby_block "Running Migrations" do
    block do
      migration_command = deploy[:migration_command] || node[:"opsworks-migrations"][:command]
      Chef::Log.info("MIGRATION COMMAND: #{migration_command}")
      Chef::Log.info(`cd #{deploy[:deploy_to]}/current &&  RAILS_ENV=#{deploy[:rails_env]} #{migration_command}`)
      raise "Migrations FAILED" unless $?.success?
    end
  end
end
