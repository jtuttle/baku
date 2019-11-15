require "spec_helper"

RSpec.describe Baku::ComponentSystem do
  describe "execute" do
    let(:system) { MockTagSystem.new }
    let(:component) { MockComponent.new }

    let(:world) { Baku::World.new }
    
    it "raises error if world reference not set" do
      expect {
        system.execute
      }.to raise_error(StandardError, "Must set :world property of System.")
    end
    
    it "processes matching entities" do
      world.add_system(system)
      
      entity = world.create_entity(["test_tag"])
      entity.add_component(component)
      
      system.execute

      expect(component.count).to eq(1)
    end
  end
end

