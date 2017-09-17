require "baku/version"

module Baku
  require 'pry-byebug'
  require 'securerandom'
  require 'set'

  require_relative "baku/event_dispatcher.rb"
  Gem.find_files("baku/**/*.rb").each { |path| require path }
end
