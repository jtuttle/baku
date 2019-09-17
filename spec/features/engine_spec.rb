require "spec_helper"

RSpec.describe Baku::World do
  it "executes update systems" do
    world = Baku::World.new
    world.add_system(MockUpdateSystem.new)

    entity = world.create_entity
    entity.add_component(MockComponent.new)
    
    world.update(MockUpdateSystem::TIME_LIMIT)

    expect(entity.get_component(MockComponent).count).to eq(1)
  end

  it "executes draw systems" do
    world = Baku::World.new
    world.add_system(MockDrawSystem.new)

    entity = world.create_entity
    entity.add_component(MockComponent.new)
    
    world.draw

    expect(entity.get_component(MockComponent).count).to eq(1)
  end
end
