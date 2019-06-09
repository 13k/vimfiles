# frozen_string_literal: true

require 'pathname'
require 'tempfile'

if Rake::VERSION < '11.0'
  abort('Rake 11.x or higher is required. Try updating it with `gem install rake`.')
end

require_relative 'lib/ruby/logging'

extend Logging

BASE_PATH = Pathname.new(__dir__)
HOME_PATH = Pathname.new(Dir.home)

XDG_CACHE_HOME = Pathname.new(ENV.fetch('XDG_CACHE_HOME', HOME_PATH.join('.cache')))
XDG_CONFIG_HOME = Pathname.new(ENV.fetch('XDG_CONFIG_HOME', HOME_PATH.join('.config')))
XDG_DATA_HOME = Pathname.new(ENV.fetch('XDG_DATA_HOME', HOME_PATH.join('.local', 'share')))

PREFIX = Pathname.new(ENV.fetch('PREFIX', HOME_PATH))
CACHE_PREFIX = Pathname.new(ENV.fetch('CACHE_PREFIX', XDG_CACHE_HOME.join('vim')))
NVIM_CACHE_PATH = XDG_DATA_HOME.join('nvim')
NVIM_CONFIG_PATH = XDG_CONFIG_HOME.join('nvim')

CACHE_NAMES = %w[
  backup
  plug
  plugged
  swap
  undo
].freeze

def cache_dirs
  @cache_dirs ||= CACHE_NAMES.map do |name|
    CACHE_PREFIX.join(name)
  end
end

def say_directory(dir)
  say "#{magenta(' /')} #{dir}"
end

def say_symlink(src, dest)
  say "#{cyan('->')} #{src} : #{dest}"
end

def directory_task(dir)
  file dir do
    say_directory(dir)
    directory dir.to_s
  end
end

def symlink_task(src, dest)
  file dest do
    say_symlink(src, dest)
    ln_sf(src, dest)
  end
end

#
# Init
#

verbose(!!ENV['VERBOSE'])

#
# Task definitions
#

cache_dirs_tasks = cache_dirs.map do |dir|
  directory_task(dir)
end

nvim_dirs_tasks = [NVIM_CACHE_PATH].map do |dir|
  directory_task(dir)
end

nvim_config_tasks = [
  symlink_task(BASE_PATH, NVIM_CONFIG_PATH),
]

#
# Task dependency tree
#

task cache_directories: cache_dirs_tasks
task nvim_directories: nvim_dirs_tasks
task nvim_config: nvim_config_tasks

task directories: [:cache_directories, :nvim_directories]
task config: [:nvim_config]

desc 'Setup vim environment'
task install: [:directories, :config]

task default: :install
