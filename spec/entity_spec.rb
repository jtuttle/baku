require "spec_helper"

RSpec.describe Baku::Entity do
  let(:entity) { Baku::Entity.new }
  let(:component) { MockComponent.new }
  
  describe "adding a component" do
    it "adds the component to the entity" do
      entity.add_component(component)
      expect(entity.components).to include(component.class)
    end

    it "raises an error if entity already has component" do
      entity.add_component(component)
      expect { entity.add_component(component) }.
        to raise_error(StandardError,
                       "Entity already has component: MockComponent")
    end
    
    it "dispatches :component_added event" do
      call_count = 0
      entity.add_event_listener(:component_added,
                                Proc.new { call_count += 1 })
      
      entity.add_component(component)
      expect(call_count).to eq(1)
    end
  end

  describe "removing a component" do
    it "removes the component from the entity" do
      entity.add_component(component)
      entity.remove_component(component.class)
      expect(entity.components).to_not include(component.class)
    end

    it "raises an error if entity does not have component" do
      expect { entity.remove_component(MockComponent) }.
        to raise_error(StandardError,
                       "Entity does not have component: MockComponent")
    end

    it "dispatches :component_removed event" do
      entity.add_component(component)
      
      call_count = 0
      entity.add_event_listener(:component_removed,
                                Proc.new { call_count += 1 })
      
      entity.remove_component(component.class)
      expect(call_count).to eq(1)
    end
  end

  describe "retrieving a component" do
    it "returns the component" do
      entity.add_component(component)
      expect(entity.get_component(component.class)).to eq(component)
    end
  end

  describe "setting tags" do
    it "sets an empty array when no tags are specified" do
      expect(entity.tags).to eq([])
    end

    it "returns the correct tags when tags are specified" do
      expect(Baku::Entity.new(["one_tag", "two_tag"]).tags).
        to eq(["one_tag", "two_tag"])
    end
  end
end
