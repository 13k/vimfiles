require 'pathname'
require 'tempfile'

if Rake::VERSION < "11.0"
  abort("Rake 11.x or higher is required. Try updating it with `gem install rake`.")
end

PWD = Pathname.new(__FILE__).dirname

$LOAD_PATH.unshift(PWD.join("lib", "ruby"))

require 'vim/bundle'
require 'vim/dotfiles'

self.extend Logging

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

#
# Init
#

verbose(!!ENV['VERBOSE'])

bundle_collection = BundleCollection.new(BUNDLES_FILE, BUNDLES_DIR)

#
# Task definitions
#

cache_dirs_tasks = cache_dirs.map do |dir|
  file dir do
    say "#{magenta("/")} #{dir.basename}"
    directory dir.to_s
  end
end

dotfiles_map.each do |src, dest|
  file dest.to_s => src.to_s do
    say "#{magenta(">")} #{src.basename}"
    mkdir_p(dest.dirname.to_s)
    ln_sf(src.to_s, dest.to_s)
  end
end

bundles_tasks = bundle_collection.bundles.map do |bundle|
  bundle_task(bundle)
end

if bundle_collection.include?("Command-T")
  install_bundle_tasks << install_bundle_task("Command-T") do |bundle|
    Dir.chdir(bundle.destination.join("ruby", "command-t")) do
      sh(%q{
         ruby extconf.rb > /dev/null &&
         make clean > /dev/null &&
         make > /dev/null
      })
    end
  end
end

clean_bundles_tasks = bundle_collection.removed_bundles.map do |bundle|
  clean_bundle_task(bundle)
end

namespace :bundles do
  task :docs do
    say "#{magenta("?")} docs"
    sh("vim", "-c", "call pathogen#helptags()", "-c", "quit")
  end
end

#
# Task dependency tree
#

task cache_directories: cache_dirs_tasks
task dotfiles_symlinks: dotfiles_map.values
task symlinks: [:dotfiles_symlinks]
task directories: [:cache_directories]

namespace :bundles do
  multitask clean: clean_bundles_tasks
  multitask download: bundles_tasks
end

desc "Install bundles"
task :bundles do
  Rake::Task["bundles:clean"].invoke
  Rake::Task["bundles:download"].invoke
  Rake::Task["bundles:docs"].invoke
end

desc "Setup the whole vim environment (symlinks, directories, bundles)"
task install: [:directories, :symlinks, :bundles]

task default: :install
