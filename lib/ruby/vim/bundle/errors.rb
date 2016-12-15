class BundleTaskError < RuntimeError
end

class BundleTaskCommandError < BundleTaskError
  def initialize(cmd, err)
    super("command failed")
    @cmd = cmd
    @err = err
  end

  def to_s
    @str ||= <<-EOF.gsub(/^\s{6}/, "")
      cmd: #{cmd.inspect}
      exception: #{@err.to_s}
      backtrace:
        #{(@err.backtrace || []).join("\n  ")}
    EOF
  end
end

class BundleTaskExternalCommandError < BundleTaskError
  def initialize(cmd_spec)
    super("external command failed")
    @cmd_spec = cmd_spec
  end

  def to_s
    @str ||= <<-EOF.gsub(/^\s{6}/, "")
      cmd: #{@cmd_spec[:cmd].inspect}
      status: #{@cmd_spec[:status].exitstatus}
      stdout: #{@cmd_spec[:stdout]}
      stderr: #{@cmd_spec[:stderr]}
    EOF
  end
end
