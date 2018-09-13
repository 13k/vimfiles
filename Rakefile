# frozen_string_literal: true

require 'pathname'
require 'tempfile'

if Rake::VERSION < '11.0'
  abort('Rake 11.x or higher is required. Try updating it with `gem install rake`.')
end

require_relative 'lib/ruby/vim/logging'

extend Logging

BASE_PATH = Pathname.new(__dir__)
XDG_CACHE_HOME = Pathname.new(ENV.fetch('XDG_CACHE_HOME', File.join(Dir.home, '.cache')))
PREFIX = Pathname.new(ENV.fetch('PREFIX', Dir.home))
CACHE_PREFIX = Pathname.new(ENV.fetch('CACHE_PREFIX', XDG_CACHE_HOME/'vim'))

CACHE_NAMES = %w[
  bundles
  swap
  backup
  undo
].freeze

def cache_dirs
  @cache_dirs ||= CACHE_NAMES.map do |name|
    CACHE_PREFIX/name
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

#
# Task dependency tree
#

task cache_directories: cache_dirs_tasks
task directories: [:cache_directories]

desc 'Setup vim environment'
task install: [:directories]

task default: :install
