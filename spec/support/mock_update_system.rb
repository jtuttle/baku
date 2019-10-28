class MockUpdateSystem < Baku::System

  TIME_LIMIT = 2

  def initialize
    super([MockComponent], :update)
  end

  def process_entity(entity, test)
    test.count += 1
  end

  def enough_time_elapsed?(delta_ms)
    2 == delta_ms
  end
end
