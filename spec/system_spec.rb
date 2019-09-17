require "spec_helper"

RSpec.describe Baku::System do
  describe "processing entities" do
    let(:system) { MockUpdateSystem.new }
    let(:component) { MockComponent.new }

    let(:world) { Baku::World.new }
    
    it "raises error if world reference not set" do
      expect {
        system.execute
      }.to raise_error(StandardError, "Must set :world property of System.")
    end
    
    it "processes matching entities" do
      world.add_system(system)

      entity = Baku::Entity.new
      entity.add_component(component)
      world.entity_manager.add_entity(entity)

      world.update(MockUpdateSystem::TIME_LIMIT)

      expect(component.count).to eq(1)
    end

    it "won't process if not enoung time elapsed" do
      world.add_system(system)

      entity = Baku::Entity.new
      entity.add_component(component)
      world.entity_manager.add_entity(entity)

      world.update(0)

      expect(component.count).to eq(0)
    end
  end
end
