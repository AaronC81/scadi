require "docile"

module Scadi
  module DSL
    # Not instance-eval'd against
    class ModifierChainer
      def initialize(element:)
        @element = element
      end
      
      def translate(*offset)
        @element.modifiers << Scadi::Model::Modifiers::Translate.new(offset: Vector3.from_array(offset))
        self
      end

      def linear_extrude(h)
        @element.modifiers << Scadi::Model::Modifiers::LinearExtrude.new(height: h)
        self
      end
      alias extrude linear_extrude
    end

    # Instance-eval'd
    class BodyBuilder
      def initialize(operation:)
        @operation = operation
      end

      def cube(*size)
        cube = Scadi::Model::Shapes::Cube.new(size: size)
        @operation << cube
        ModifierChainer.new(element: cube)
      end

      def square(*size)
        square = Scadi::Model::Shapes::Square.new(size: size)
        @operation << square
        ModifierChainer.new(element: square)
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
