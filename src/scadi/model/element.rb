require_relative "../util"

module Scadi
  module Model
    # Something which exists in a model, inserting new geometry when rendering.
    class Element
      extend Util::Abstract

      def initialize(parent:)
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
    end
  end
end
