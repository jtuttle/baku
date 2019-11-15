require_relative 'system'

module Baku
  class TagSystem < System
    attr_reader :tag
    
    def initialize(tag, game_loop_step)
      @tag = tag
      @game_loop_step = game_loop_step
    end

    def process_entities(entities)
      entities.each do |entity|
        process_entity(entity)
      end
    end
    
    protected
    
    def retrieve_entities
      @world.entity_manager.get_entities_by_tag(@tag)
    end
  end
end
