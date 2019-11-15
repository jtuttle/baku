class MockDrawSystem < Baku::ComponentSystem
  def initialize
    super([MockComponent], :draw)
  end

  def process_entity(entity, mock)
    mock.count += 1
  end
end
