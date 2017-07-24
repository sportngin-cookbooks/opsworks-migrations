include_attribute "deploy::default"

default[:opsworks_migrations][:dir] = "migrations"
default[:opsworks_migrations][:bundler_path] = 'bundle'
default[:opsworks_migrations][:command] = "#{node[:opsworks_migrations][:bundler_path]} exec rake db:migrate db:version"
default[:opsworks_migrations][:timeout] = 600
