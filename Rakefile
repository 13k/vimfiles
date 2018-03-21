# frozen_string_literal: true

require 'pathname'
require 'tempfile'

if Rake::VERSION < '11.0'
  abort('Rake 11.x or higher is required. Try updating it with `gem install rake`.')
end

BASE_PATH = Pathname.new(__dir__)

require_relative 'lib/ruby/vim/logging'
require_relative 'lib/ruby/vim/dotfiles'

extend Logging

DOTFILES_NAME = 'dotfiles'
CACHE_NAMES = %w[
  bundles
  swap
  backup
  undo
].freeze

XDG_CACHE_HOME = Pathname.new(ENV.fetch('XDG_CACHE_HOME', File.join(Dir.home, '.cache')))
PREFIX = Pathname.new(ENV.fetch('PREFIX', Dir.home))
CACHE_PREFIX = Pathname.new(ENV.fetch('CACHE_PREFIX', XDG_CACHE_HOME/'vim'))
DOTFILES_DIR = BASE_PATH/DOTFILES_NAME

def cache_dirs
  @cache_dirs ||= CACHE_NAMES.map do |name|
    CACHE_PREFIX/name
  end
end

def dotfiles_map
  @dotfiles_map ||= begin
    dotfiles(DOTFILES_DIR).reduce({}) do |map, src|
      rel = src.relative_path_from(DOTFILES_DIR)
      dest = PREFIX/".#{rel}"
      map.update(src => dest)
    end
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
  file dir do
    say "#{magenta('/')} #{dir.basename}"
    directory dir.to_s
  end
end

dotfiles_map.each do |src, dest|
  file dest.to_s => src.to_s do
    say "#{magenta('>')} #{src.basename}"
    mkdir_p(dest.dirname.to_s)
    ln_sf(src.to_s, dest.to_s)
  end
end

#
# Task dependency tree
#

task cache_directories: cache_dirs_tasks
task dotfiles_symlinks: dotfiles_map.values
task symlinks: [:dotfiles_symlinks]
task directories: [:cache_directories]

desc 'Setup the whole vim environment'
task install: [:directories, :symlinks]

task default: :install
