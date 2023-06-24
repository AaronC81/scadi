require_relative "../modifier"

module Scadi
  module Model
    module Modifiers
      # A transform (movement) of this modifiers's target element.
      class Transform < Modifier
        def initialize(offset:)
          super
          @offset = offset
        end

        # The offset of the target element, as a `Vector3`
        attr_accessor :offset
      end
    end
  end
end
