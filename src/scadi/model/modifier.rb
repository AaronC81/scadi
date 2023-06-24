require_relative "../util"

module Scadi
  module Model
    # A modifier which is applied to one element, changing its geometry somehow.
    class Modifier
      # Compiles this element into a string of OpenSCAD code.
      def to_openscad = abstract!
    end
  end
end
