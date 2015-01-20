site :opscode

def opsworks_cookbook(name, branch='release-chef-11.4')
  cookbook name, github: 'aws/opsworks-cookbooks', branch: branch, rel: name
end

opsworks_cookbook 'opsworks_initial_setup'
opsworks_cookbook 'opsworks_commons'
opsworks_cookbook 'dependencies'
opsworks_cookbook 'deploy'

# opsworks_cookbook transitive dependencies
%w[apache2 mod_php5_apache2 nginx ssh_users opsworks_agent_monit passenger_apache2 unicorn opsworks_bundler rails
  opsworks_rubygems opsworks_java php mysql opsworks_postgresql ruby ruby_enterprise packages gem_support scm_helper].each do |book|
  opsworks_cookbook book
end

metadata