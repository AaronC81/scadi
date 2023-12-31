require_relative "../modifier"

module Scadi
  module Model
    module Modifiers
      # A translation (movement) of this modifiers's target element.
      class Translate < Modifier
        def initialize(offset:)
          super()
          @offset = offset
        end

        # The offset of the target element, as a `Vector3`
        attr_accessor :offset

        def to_openscad = "translate(#{offset.to_openscad})"
      end
    end
  end
end
