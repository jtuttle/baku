class MockUpdateSystem < Baku::ComponentSystem
  def initialize
    super([MockComponent], :update)
  end

  def process_entity(entity, mock)
    mock.count += 1
  end
end
