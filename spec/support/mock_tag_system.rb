class MockTagSystem < Baku::TagSystem
  def initialize
    super("test_tag", :update)
  end

  def process_entity(entity)
    mock = entity.get_component(MockComponent)
    mock.count += 1
  end
end
