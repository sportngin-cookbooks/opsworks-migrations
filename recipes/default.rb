include_recipe "deploy"

node[:deploy].each do |application, deploy|
  node.default[:migrations_dir] = "migrations"
  node.override[:deploy][application][:deploy_to] = "#{deploy[:deploy_to]}/#{deploy[:migrations_dir]}"
  node.default[:deploy][application][:migration_command] = "bundle exec rake db:migrate"
  Chef::Log.info("DEPLOY_TO: #{deploy[:deploy_to]}")
  Chef::Log.info("FULL PATH DEPLOY_TO: #{node[:deploy][application][:deploy_to]}")
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
      Chef::Log.info(`cd #{deploy[:deploy_to]}/current &&  RAILS_ENV=#{deploy[:rails_env]} #{deploy[:migration_command]}`)
      raise "Migrations FAILED" unless $?.success?
    end
  end
end
