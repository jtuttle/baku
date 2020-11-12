require "spec_helper"

RSpec.describe Baku::EntityManager do
  let(:entity_manager) { Baku::EntityManager.new }
  let(:system) { MockUpdateSystem.new }

  let(:match_entity) { Baku::Entity.new }
  let(:tagged_entity) { Baku::Entity.new([:some_tag]) }

  before do
    entity_manager.register_component_mask(system.component_mask)
    match_entity.add_component(MockComponent.new)
  end

  describe "registering an entity" do
    before do
      entity_manager.add_entity(match_entity)
    end

    it "associates the entity with its matching systems" do
      expect(entity_manager.get_entities(system.component_mask)).
        to eq([match_entity])
    end

    it "does not add the entity multiple times" do
      match_entity.add_component(AnotherMockComponent.new)

      expect(entity_manager.get_entities(system.component_mask)).
        to eq([match_entity])
    end
  end

  describe "registering a component mask" do
    before do
      entity_manager.add_entity(match_entity)
    end

    it "doesn't override entities if the component mask has already been registered" do
      expect { entity_manager.register_component_mask(system.component_mask) }
        .not_to change { entity_manager.get_entities(system.component_mask) }
    end
  end

  describe "removing an entity" do
    before do
      entity_manager.add_entity(match_entity)
      entity_manager.remove_entity(match_entity)
    end

    it "disassociates the entity with its matching systems" do
      expect(entity_manager.get_entities(system.component_mask)).
        to eq([])
    end
  end

  describe "retrieving entities for a system" do
    let(:no_match_entity) { Baku::Entity.new }

    before do
      entity_manager.add_entity(no_match_entity)
    end

    it "returns empty array if no entities found" do
      expect(entity_manager.get_entities(system.component_mask)).
        to eq([])
    end

    it "only returns entities that match the system signature" do
      entity_manager.add_entity(match_entity)

      expect(entity_manager.get_entities(system.component_mask)).
        to eq([match_entity])
    end
  end

  describe "retrieving entities by tag" do
    let(:untagged_entity) { Baku::Entity.new }
    let(:other_tagged_entity) { Baku::Entity.new([:other_tag]) }

    before do
      entity_manager.add_entity(untagged_entity)
      entity_manager.add_entity(other_tagged_entity)
    end

    it "returns empty array if no entities found" do
      expect(entity_manager.get_entities_by_tag(:empty_tag)).
        to eq([])
    end

    it "returns only the entities with a matching tag" do
      entity_manager.add_entity(tagged_entity)

      expect(entity_manager.get_entities_by_tag(:some_tag)).
        to eq([tagged_entity])
    end
  end

  describe "adding a component to an existing entity" do
    let(:entity) { Baku::Entity.new }
    let(:component) { MockComponent.new }

    before do
      entity_manager.add_entity(entity)
    end

    it "adds the entity to a matching component list" do
      entity.add_component(component)
      expect(entity_manager.get_entities(entity.component_mask)).
        to eq([entity])
    end
  end

  describe "removing a component from an existing entity" do
    let(:entity) { Baku::Entity.new }
    let(:component) { MockComponent.new }

    before do
      entity_manager.add_entity(entity)
      entity.add_component(component)
    end

    it "removes the entity to a matching component list" do
      mask = entity.component_mask
      entity.remove_component(MockComponent)
      expect(entity_manager.get_entities(entity.component_mask)).
        to eq([])
    end
  end

  describe "disposing" do
    before do
      entity_manager.add_entity(match_entity)
      entity_manager.add_entity(tagged_entity)
    end

    it "removes references to entities" do
      entity_manager.dispose
      expect(entity_manager.get_entities(match_entity.component_mask)).
        to eq([])
    end

    it "removes references to tagged entities" do
      entity_manager.dispose
      expect(entity_manager.get_entities_by_tag(:some_tag)).
        to eq([])
    end
  end
end

