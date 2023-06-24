require_relative "../util"

module Scadi
  module Model
    # Something which exists in a model, inserting new geometry when rendering.
    class Element
      extend Util::Abstract

      def initialize(parent: nil)
        @parent = parent
        @modifiers = []
      end

      # The domain in which this element creates geometry. One of `:d2`, `:d3`, or `nil` if it is
      # indeterminate for some reason.
      def domain = abstract!

      # The container which this element belongs to.
      attr_accessor :parent

      # Any modifiers applied to this element. Modifiers are applied in the order that they appear
      # in this list.
      attr_accessor :modifiers

      # Compiles this element into a string of OpenSCAD code, including any modifiers.
      # This is a complete statement, including a semicolon if required.
      def to_openscad
        if modifiers.any?
          modifier_string = modifiers.reverse.map(&:to_openscad).join(' ')
          "#{modifier_string} #{base_to_openscad}"
        else
          base_to_openscad
        end
      end

      # Compiles this element into a string of OpenSCAD code, excluding any modifiers.
      # This is a complete statement, including a semicolon if required.
      def base_to_openscad = abstract!
    end
  end
end
