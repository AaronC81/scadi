require_relative "../shape"

module Scadi
  module Model
    module Shapes
      # A 3-dimensional cube/cuboid.
      class Cube < Element
        def initialize(size:, **kw)
          super(**kw)
          @size = size
        end

        # The size of this cube, as a `Vector3`
        attr_accessor :size

        def domain = :d3
      end
    end
  end
end
