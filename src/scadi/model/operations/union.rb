require_relative "../operation"

module Scadi
  module Model
    module Operations
      # The simplest possible operation, which combines all child elements into one.
      class Union < Operation
        def base_to_openscad = "union() { #{children.map(&:to_openscad).join(" ")} }"
      end
    end
  end
end
