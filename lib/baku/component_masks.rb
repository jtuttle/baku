module Baku
  class ComponentMasks
    def initialize(component_namespace)
      @component_set = Set.new

      component_namespace.constants.each do |component_class|
        @component_set << component_class
      end
    end

    def get_mask(components)
      mask = 0

      @component_set.each_with_index do |component, index|
        mask |= (1 << index) if components.include?(component)
      end

      mask
    end
  end
end
