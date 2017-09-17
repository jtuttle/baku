require "spec_helper"

RSpec.describe Baku::EntityManager do
  let(:entity_manager) { Baku::EntityManager.new }
  let(:mock_system) { MockUpdateSystem.new }

  let(:match_entity) { Baku::Entity.new }
  let(:no_match_entity) { Baku::Entity.new }
  
  before do
    entity_manager.register_system(mock_system)
  end

  describe "registering an entity" do
    before do
      entity_manager.add_entity(match_entity)
      match_entity.add_component(MockComponent.new)
    end

    it "associates the entity with its matching systems" do
      expect(entity_manager.get_entities_by_system(mock_system)).
        to eq([match_entity])
    end
  end

  describe "removing an entity" do
    before do
      entity_manager.add_entity(match_entity)
      match_entity.add_component(MockComponent.new)

      entity_manager.remove_entity(match_entity)
    end

    it "disassociates the entity with its matching systems" do
      expect(entity_manager.get_entities_by_system(mock_system)).
        to eq([])
    end
  end
  
  describe "retrieving entities for a system" do
    before do
      entity_manager.add_entity(match_entity)
      match_entity.add_component(MockComponent.new)
      
      entity_manager.add_entity(no_match_entity)      
    end

    it "only returns entities that match the system signature" do
      expect(entity_manager.get_entities_by_system(mock_system)).
        to eq([match_entity])
    end
  end
  
  describe "retrieving entities by tag" do
    let(:tagged_entity) { Baku::Entity.new([:some_tag]) }
    let(:no_tag_entity) { Baku::Entity.new }

    before do
      entity_manager.add_entity(tagged_entity)
      entity_manager.add_entity(no_tag_entity)
    end

    it "returns only the tagged entities" do
      expect(entity_manager.get_entities_by_tag(:some_tag)).
        to eq([tagged_entity])
    end
  end
end
