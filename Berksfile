site :opscode

opsworks_cookbook 'opsworks_initial_setup'
opsworks_cookbook 'opsworks_commons'
opsworks_cookbook 'dependencies'
opsworks_cookbook 'deploy'

# opsworks_cookbook transitive dependencies
%w[apache2 mod_php5_apache2 nginx ssh_users opsworks_agent_monit passenger_apache2 unicorn opsworks_commons
    opsworks_java php mysql opsworks_postgresql ruby ruby_enterprise packages gem_support].each do |book|
  cookbook name, github: 'aws/opsworks-cookbooks', branch: 'release-chef-11.4', rel: name
end
