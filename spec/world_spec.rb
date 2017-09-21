require "spec_helper"

RSpec.describe Baku::World do
  let(:world) { Baku::World.new }
  
  describe "creating an entity" do
    it "returns an entity object" do
      expect(world.create_entity.class).to eq(Baku::Entity)
    end

    it "adds tags to the entity" do
      expect(world.create_entity(["tag1", "tag2"]).tags).to eq(["tag1", "tag2"])
    end

    it "registers the entity with the entity manager" do
      expect(world.entity_manager).to receive(:add_entity)
      world.create_entity
    end
  end

  describe "destroying an entity" do
    let(:entity) { world.create_entity }
    
    it "removes the entity from the entity manager" do
      expect(world.entity_manager).to receive(:remove_entity).with(entity)
      world.destroy_entity(entity)
    end
  end

  describe "running systems" do
    let(:update_system) { MockUpdateSystem.new }
    let(:draw_system) { MockDrawSystem.new }
    let(:entity) { world.create_entity }
    let(:component) { MockComponent.new }

    it "runs update systems correctly" do
      world.add_system(update_system)
      entity.add_component(component)
      world.update(1)

      expect(component.count).to eq(1)
    end

    it "runs draw systems correctly" do
      world.add_system(draw_system)
      entity.add_component(component)
      world.draw

      expect(component.count).to eq(1)
    end
  end
end
