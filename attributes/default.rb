include_attribute "deploy::default"

default[:opsworks_migrations][:dir] = "migrations"
default[:opsworks_migrations][:command] = "bundle exec rake db:migrate db:version"
default[:opsworks_migrations][:timeout] = 600
