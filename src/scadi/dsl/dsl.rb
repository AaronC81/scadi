require "docile"

module Scadi
  module DSL
    # Not instance-eval'd against
    class ModifierChainer
      def initialize(element:)
        @element = element
      end
      
      def translate(x, y, z=0)
        @element.modifiers << Scadi::Model::Modifiers::Translate.new(offset: Vector3.new(x, y, z))
        self
      end
    end

    # Instance-eval'd
    class BodyBuilder
      def initialize(operation:)
        @operation = operation
      end

      def cube(x, y, z)
        cube = Scadi::Model::Shapes::Cube.new(size: Vector3.new(x, y, z))
        @operation << cube
        ModifierChainer.new(element: cube)
      end

      def union(&block)
        union = Scadi::Model::Operations::Union.new
        @operation << union
        Docile.dsl_eval(BodyBuilder.new(operation: union), &block)
        ModifierChainer.new(element: union)
      end
    end

    def self.use(&block)
      root = Scadi::Model::Operations::Union.new
      BodyBuilder.new(operation: root)
        .union(&block)
        .instance_variable_get(:@element)
    end
  end
end
