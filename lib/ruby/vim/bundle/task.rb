require 'rake'

require 'vim/bundle/errors'
require 'vim/bundle/logging'

class BundleTaskDefinition
  attr_reader :bundle

  def initialize(bundle)
    @bundle = bundle
  end

  def commands
    commands = []

    if File.exist?(bundle.task_name)
      say "#{blue("^")} #{bundle.name}"
      commands = update_commands
    else
      say "#{green("+")} #{bundle.name}"
      commands = create_commands
    end

    unless Enumerable === commands
      commands = Array(commands)
    end

    commands
  end

  private

  def create_commands
    case bundle.src
    when :fs
      -> {
        rm_rf(bundle.destination.to_s)
        cp_r(bundle.uri.path, bundle.destination.to_s, preserve: true)
      }
    when :git
      [
        ["git", "clone", "--quiet", bundle.url, bundle.destination.to_s],
      ]
    when :hg
      [
        ["hg", "clone", "--quiet", bundle.url, bundle.destination.to_s],
      ]
    else
      raise BundleTaskError.new("Invalid bundle src #{bundle.src.inspect}")
    end
  end

  def update_commands
    case bundle.src
    when :fs
      -> {
        rm_rf(bundle.destination.to_s)
        cp_r(bundle.uri.path, bundle.destination.to_s, preserve: true)
      }
    when :git
      [
        ["git", "-C", bundle.destination.to_s, "reset", "--quiet", "--hard"],
        ["git", "-C", bundle.destination.to_s, "pull", "--quiet", "--no-rebase"],
      ]
    when :hg
      [
        ["hg", "-R", bundle.destination.to_s, "--quiet", "pull", "-u"],
      ]
    else
      raise BundleTaskError.new("Invalid bundle src #{bundle.src.inspect}")
    end
  end

  def eval_cmd(cmd)
    begin
      cmd.call
    rescue => err
      raise BundleTaskCommandError.new(cmd, err)
    end
  end

  def spawn_cmd(cmd)
    out = Tempfile.new("rake_task.stdout")
    err = Tempfile.new("rake_task.stderr")

    begin
      result = {}

      sh(*cmd, :out => out.path, :err => err.path) do |ok, status|
        result.update(success: ok, status: status)
      end

      unless result[:success]
        raise BundleTaskExternalCommandError.new({
          cmd: cmd,
          result: result,
          stdout: out.read,
          stderr: err.read,
        })
      end
    ensure
      out.close!
      err.close!
    end
  end
end

class BundleTask < Rake::Task
  def self.create(bundle)
    BundleTask.define_task(bundle.task_name) do |task|
      task.run(bundle)
    end
  end

  def needed?
    true
  end

  def run(bundle)
    taskDef = BundleTaskDefinition.new(bundle)

    taskDef.commands.each do |cmd|
      begin
        if cmd.respond_to?(:call)
          eval_cmd(cmd)
        else
          spawn_cmd(cmd)
        end
      rescue BundleTaskError => err
        say <<-EOF.gsub(/^\s{10}/, "")
          #{red("!")} #{err.message}
            #{err.to_s.gsub(/\n/, "\n  ")}
        EOF

        break
      end
    end
  end
end

def bundle_task(bundle, &block)
  if block_given?
    if BundleTask.task_defined?(bundle.task_name)
      BundleTask[bundle.task_name].enhance(&block)
    end
  else
    BundleTask.create(bundle)
  end
end

def install_bundle_task(name, &block)
  action = proc do |*args|
    say "#{magenta("$")} #{name}"
    block.call(bundle, *args)
  end

  bundle_task(bundle, &action)
end

def clean_bundle_task(bundle)
  Rake::Task.define_task(bundle.task_name) do
    say "#{yellow("-")} #{bundle.name}"
    rm_rf bundle.destination
  end
end
