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

      def cube(*size) = _handle(Scadi::Model::Shapes::Cube.new(size: size))
      def square(*size) = _handle(Scadi::Model::Shapes::Square.new(size: size))

      def union(&block) = _handle(Scadi::Model::Operations::Union.new, &block)
      def difference(&block) = _handle(Scadi::Model::Operations::Difference.new, &block)
      def intersection(&block) = _handle(Scadi::Model::Operations::Intersection.new, &block)

      private def _handle(element, &block)
        @operation << element
        Docile.dsl_eval(BodyBuilder.new(operation: element), &block) if block
        ModifierChainer.new(element: element)
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
