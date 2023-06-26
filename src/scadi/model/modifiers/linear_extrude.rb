require_relative "../modifier"

module Scadi
  module Model
    module Modifiers
      # Transforms a 2D element into a 3D one by pulling the 2D element "upwards" to match a
      # specified height.
      class LinearExtrude < Modifier
        def initialize(height:)
          super()
          @height = height
        end

        # The height to extrude.
        attr_accessor :height

        def to_openscad = "linear_extrude(#{height})"
      end
    end
  end
end
