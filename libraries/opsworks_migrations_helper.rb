module OpsworksMigrations
  class Helper
    def initialize(node)
      @node = node
    end

    def dir
      @node.fetch(:"opsworks-migrations", {})[:dir] || @node[:opsworks_migrations][:dir]
    end

    def command
      @node.fetch(:"opsworks-migrations", {})[:command] || @node[:opsworks_migrations][:command]
    end

    def shellout(command, options = {})
      cmd = Mixlib::ShellOut.new(command, options)
      cmd.run_command
      cmd.error!
      [cmd.stderr, cmd.stdout].join("\n")
    end
  end
end