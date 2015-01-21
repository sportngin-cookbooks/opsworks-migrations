module OpsworksMigrations
  def dir
    node[:"opsworks-migrations"][:dir] || node[:opsworks_migrations][:dir]
  end

  def command
    node[:"opsworks-migrations"][:command] || node[:opsworks_migrations][:command]
  end
end