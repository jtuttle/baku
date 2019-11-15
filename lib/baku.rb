require "baku/version"

module Baku
  begin
    require 'pry-byebug'
  rescue LoadError
    # development dependencies
  end

  require 'set'
  
  require 'miru'

  Gem.find_files("baku/**/*.rb").each { |path| require path }
end
