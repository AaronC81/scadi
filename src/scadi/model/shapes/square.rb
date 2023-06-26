require_relative "../shape"

module Scadi
  module Model
    module Shapes
      # A 2-dimensional square/rectangle.
      class Square < Element
        def initialize(size:, **kw)
          super(**kw)
          @size = Vector2.from_array(size)
        end

        # The size of this cube, as a `Vector2`
        attr_accessor :size

        def domain = :d2

        def base_to_openscad = "square(#{size.to_openscad});"
      end
    end
  end
end
