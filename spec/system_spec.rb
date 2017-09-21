require "spec_helper"

RSpec.describe Baku::System do
  describe "processing entities" do
    let(:system) { MockUpdateSystem.new }
    let(:component) { MockComponent.new }

    let(:entity_manager) { Baku::EntityManager.new }

    before do
      entity_manager.register_component_mask(system.component_mask)
    end
    
    it "raises error if entity manager reference not set" do
      expect { system.process_entities }.to raise_error {
        StandardError.new("Must set :entity_manager property of System.")
      }
    end
    
    it "processes the entities it is given" do
      entity = Baku::Entity.new
      entity.add_component(component)
      entity_manager.add_entity(entity)
      
      system.entity_manager = entity_manager
      system.process_entities

      expect(component.count).to eq(1)
    end
  end
end
