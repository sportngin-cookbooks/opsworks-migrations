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

  Chef::Log.info("Running Bundle Install")
  Chef::Log.info(OpsWorks::ShellOut.shellout("cd #{deploy[:deploy_to]}/current &&  bundle install --path #{deploy[:deploy_to]}/shared/bundle --without=test development --deployment"))

  migration_command = deploy[:migration_command] || node[:"opsworks-migrations"][:command]
  Chef::Log.info("Running Migrations")
  Chef::Log.info(OpsWorks::ShellOut.shellout("cd #{deploy[:deploy_to]}/current &&  RAILS_ENV=#{deploy[:rails_env]} #{migration_command}"))
  end
end
