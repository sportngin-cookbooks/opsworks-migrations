include_attribute "deploy::default"

default[:"opsworks-migrations"][:dir] = "migrations"
default[:"opsworks-migrations"][:command] = "bundle exec rake db:migrate"
