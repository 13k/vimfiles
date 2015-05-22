require 'pathname'

PWD = Pathname.new(__FILE__).dirname

$LOAD_PATH.unshift(PWD.join("lib", "ruby"))

require 'vim/bundle'
require 'vim/dotfiles'

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
        ["git", "--git-dir=#{bundle.destination}/.git", "pull", "--quiet", "--no-rebase"]
      when :hg
        ["hg", "--repository=#{bundle.destination}", "--quiet", "pull"]
    end
  end

  def download_cmd(bundle)
    case bundle.scm
      when :git
        ["git", "clone", "--quiet", bundle.url, bundle.destination.to_s]
      when :hg
        ["hg", "clone", "--quiet", bundle.url, bundle.destination.to_s]
    end
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
        cmd = task.update_cmd(bundle)
      else
        cmd = task.download_cmd(bundle)
      end

      sh(*cmd)
    end
  end
end

def install_bundle_task(name, &block)
  if bundle = find_bundle(name)
    action = proc do |*args|
      block.call(bundle, *args)
    end
    bundle_task(bundle, &action)
  end
end

def clean_bundle_task(name)
  bundle = Bundle.new(name: bundle_name)

  Rake::Task.define_task(bundle.task_name) do
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

cache_dirs.each do |dir|
  directory dir
end

dotfiles_map.each do |src, dest|
  file dest => src do
    mkdir_p(dest.dirname)
    ln_sf(src, dest)
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
    sh("vim", "-c", "call pathogen#helptags()", "-c", "quit")
  end
end

task :bundles do
  puts "--> Installing bundles ..."
  Rake::Task["bundles:install"].invoke
  puts "--> Updating bundles docs ..."
  Rake::Task["bundles:docs"].invoke
  puts "--> Done"
end

task install: [:symlinks, :directories, :bundles]

task default: :install
