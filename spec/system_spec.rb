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
      
      system.execute

      expect(component.count).to eq(1)
    end
  end
end
