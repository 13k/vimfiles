require 'pathname'
require 'tempfile'
require 'thread'

if Rake::VERSION < "11.0"
  abort("Rake 11.x or higher is required. Try updating it with `gem install rake`.")
end

PWD = Pathname.new(__FILE__).dirname

$LOAD_PATH.unshift(PWD.join("lib", "ruby"))

require 'vim/bundle'
require 'vim/dotfiles'

LOG_M = Mutex.new

DOTFILES_NAME = "dotfiles".freeze
CACHE_NAMES = %w[
  bundles
  swap
  backup
  undo
].freeze

XDG_CACHE_HOME = Pathname.new(ENV['XDG_CACHE_HOME'] || File.join(Dir.home, '.cache'))
PREFIX = Pathname.new(ENV['PREFIX'] || Dir.home)
CACHE_PREFIX = Pathname.new(ENV['CACHE_PREFIX'] || XDG_CACHE_HOME + "vim")
DOTFILES_DIR = PWD + DOTFILES_NAME
BUNDLES_DIR = CACHE_PREFIX + "bundles"
BUNDLES_FILE = PWD + "bundles.yml"

module Rake
  class << self
    alias_method :rake_output_message_orig, :rake_output_message
    def rake_output_message(*args, &block)
      LOG_M.synchronize do
        rake_output_message_orig(*args, &block)
      end
    end
  end
end

module Colors
  def colorize(text, color_code)
    "\033[#{color_code}m#{text}\033[0m"
  end

  {
    :black    => 30,
    :red      => 31,
    :green    => 32,
    :yellow   => 33,
    :blue     => 34,
    :magenta  => 35,
    :cyan     => 36,
    :white    => 37
  }.each do |key, color_code|
    define_method key do |text|
      colorize(text, color_code)
    end
  end
end

class Bundle < OpenStruct
  def destination
    BUNDLES_DIR + name
  end

  def task_name
    destination
  end
end

class BundleTask < Rake::Task
  def needed?
    true
  end

  def update_cmd(bundle)
    case bundle.scm
      when :git
        [
          ["git", "-C", bundle.destination.to_s, "reset", "--quiet", "--hard"],
          ["git", "-C", bundle.destination.to_s, "pull", "--quiet", "--no-rebase"],
        ]
      when :hg
        [
          ["hg", "-R", bundle.destination.to_s, "--quiet", "pull", "-u"],
        ]
    end
  end

  def download_cmd(bundle)
    case bundle.scm
      when :git
        [
          ["git", "clone", "--quiet", bundle.url, bundle.destination.to_s],
        ]
      when :hg
        [
          ["hg", "clone", "--quiet", bundle.url, bundle.destination.to_s],
        ]
    end
  end
end

def say(msg)
  LOG_M.synchronize do
    STDOUT.puts(msg)
    STDOUT.flush
  end
end

def bundles
  @bundles ||= load_bundles(BUNDLES_FILE).map {|b| Bundle.new(b) }
end

def find_bundle(name)
  bundles.find {|b| b.name == name.to_s }
end

def bundle_task(bundle, &block)
  if block_given?
    if BundleTask.task_defined?(bundle.task_name)
      BundleTask[bundle.task_name].enhance(&Proc.new)
    end
  else
    BundleTask.define_task(bundle.task_name) do |task|
      if File.exist?(task.name)
        say "#{blue("^")} #{bundle.name}"
        commands = task.update_cmd(bundle)
      else
        say "#{green("+")} #{bundle.name}"
        commands = task.download_cmd(bundle)
      end

      success = true
      commands.each do |cmd|
        out = Tempfile.new("rake_task.stdout")
        err = Tempfile.new("rake_task.stderr")

        begin
          sh(*cmd, :out => out.path, :err => err.path) do |ok, status|
            if !ok
              say <<-EOF.gsub(/^\s{16}/, "")
                #{red("!")} command failed
                  cmd: #{cmd.inspect}
                  status: #{status.exitstatus}
                  stdout: #{out.read.inspect}
                  stderr: #{err.read.inspect}
              EOF
              break
            end
          end
        ensure
          out.close!
          err.close!
        end
      end
    end
  end
end

def install_bundle_task(name, &block)
  if bundle = find_bundle(name)
    action = proc do |*args|
      say "#{magenta("$")} #{name}"
      block.call(bundle, *args)
    end
    bundle_task(bundle, &action)
  end
end

def clean_bundle_task(name)
  bundle = Bundle.new(name: name)

  Rake::Task.define_task(bundle.task_name) do
    say "#{yellow("-")} #{name}"
    rm_rf bundle.destination
  end
end

def cache_dirs
  @cache_dirs ||= CACHE_NAMES.map do |name|
    CACHE_PREFIX + name
  end
end

def dotfiles_map
  @dotfiles_map ||= begin
    dotfiles(DOTFILES_DIR).reduce({}) do |map, src|
      rel = src.relative_path_from(DOTFILES_DIR)
      dest = PREFIX + ".#{rel}"
      map.update(src => dest)
    end
  end
end

include Colors

verbose(!!ENV['VERBOSE'])

cache_dirs.each do |dir|
  say "#{magenta("/")} #{dir.basename}"
  directory dir.to_s
end

dotfiles_map.each do |src, dest|
  file dest.to_s => src.to_s do
    say "#{magenta(">")} #{src.basename}"
    mkdir_p(dest.dirname.to_s)
    ln_sf(src.to_s, dest.to_s)
  end
end

bundles_tasks = bundles.map do |bundle|
  bundle_task(bundle)
end

install_bundle_task "Command-T" do |bundle|
  Dir.chdir(bundle.destination.join("ruby", "command-t")) do
    sh(%q{
       ruby extconf.rb > /dev/null &&
       make clean > /dev/null &&
       make > /dev/null
    })
  end
end

clean_bundles_tasks = Dir[BUNDLES_DIR + "*"].reduce([]) do |tasks, dir|
  name = File.basename(dir)
  tasks << clean_bundle_task(name) unless find_bundle(name)
  tasks
end

task cache_directories: cache_dirs
task dotfiles_symlinks: dotfiles_map.values
task symlinks: [:dotfiles_symlinks]
task directories: [:cache_directories]

namespace :bundles do
  multitask clean: clean_bundles_tasks
  multitask download: bundles_tasks
  multitask install: [:clean, :download]

  task :docs do
    say "#{magenta("?")} docs"
    sh("vim", "-c", "call pathogen#helptags()", "-c", "quit")
  end
end

desc "Install bundles"
task :bundles do
  Rake::Task["bundles:clean"].invoke
  Rake::Task["bundles:download"].invoke
  Rake::Task["bundles:docs"].invoke
end

desc "Setup the whole vim environment (symlinks, directories, bundles)"
task install: [:symlinks, :directories, :bundles]

task default: :install
