require "baku/version"

module Baku
  begin
    require 'pry-byebug'
  rescue LoadError
    # development dependencies
  end
    
  require 'set'

  require_relative "baku/event_dispatcher.rb"
  Gem.find_files("baku/**/*.rb").each { |path| require path }
end
