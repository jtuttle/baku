require "spec_helper"

RSpec.describe Baku::ComponentMask do
  describe "component mask creation" do
    it "creates a component mask with the correct value" do
      expect(Baku::ComponentMask.from_components([ MockComponent ])).
        to eq(Baku::ComponentMask.new(1))
    end
  end

  describe "component mask matching" do
    it "considers component masks with overlapping bits as matching" do
      expect(Baku::ComponentMask.new(1).matches?(Baku::ComponentMask.new(3))).
        to eq(true)
    end
    
    it "considers component masks with non-overlapping bits as not matching" do
      expect(Baku::ComponentMask.new(1).matches?(Baku::ComponentMask.new(2))).
        to eq(false)
    end
  end
  
  describe "component mask equality" do    
    it "considers two component masks with the same value as equal" do
      expect(Baku::ComponentMask.new(1)).
        to eq(Baku::ComponentMask.new(1))
    end

    it "considers two component masks with different values as not equal" do
      expect(Baku::ComponentMask.new(1)).
        to_not eq(Baku::ComponentMask.new(2))
    end

    it "considers two component masks with the same value to be the same hash key" do
      hash = { Baku::ComponentMask.new(1) => true }
      expect(hash[Baku::ComponentMask.new(1)]).to eq(true)
    end

    it "considers two component masks with different values to be different hash keys" do
      hash = { Baku::ComponentMask.new(1) => true }
      expect(hash[Baku::ComponentMask.new(2)]).to eq(nil)
    end
  end
end
