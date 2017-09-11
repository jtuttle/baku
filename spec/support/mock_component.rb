class MockComponent < Baku::Component
  attr_accessor :count

  def initialize
    @count = 0
  end
end
