# frozen_string_literal: true

require 'thread'

LOG_M = Mutex.new

# Hack to synchronize rake output messages
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

module Logging
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

  def say(msg)
    LOG_M.synchronize do
      STDOUT.puts(msg)
      STDOUT.flush
    end
  end
end
