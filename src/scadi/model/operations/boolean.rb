require_relative "../operation"

module Scadi
  module Model
    module Operations
      # The simplest possible operation, which combines all child elements into one.
      class Union < Operation
        def base_to_openscad = "union() { #{children.map(&:to_openscad).join(" ")} }"
      end

      # Renders the first child, then subtracts all subsequent children.
      class Difference < Operation
        def base_to_openscad = "difference() { #{children.map(&:to_openscad).join(" ")} }"
      end

      # Produces the overlapping geometry of all children.
      class Intersection < Operation
        def base_to_openscad = "intersection() { #{children.map(&:to_openscad).join(" ")} }"
      end
    end
  end
end
