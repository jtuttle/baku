class MockUpdateSystem < Baku::System
  def initialize
    super([MockComponent], :update)
  end

  def process_entity(entity, test)
    test.count += 1
  end
end
