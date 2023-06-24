require_relative "element"

module Scadi
  module Model
    # An element which groups together many child elements, applying some kind of combinatorial
    # operation to their geometry.
    class Operation < Element
      def initialize(**kw)
        super(**kw)
        @children = []
      end

      # The children of this operation.
      attr_reader :children

      # Adds an element as a child of this operation, also setting its parent to this.
      def add_child(child)
        children << child
        child.parent = self
      end
      alias << add_child

      def domain
        # If all children have the same domain, use that. Otherwise, we dunno
        unique_domains = children.map(&:domain).uniq
        if unique_domains.length == 1
          unique_domains.first
        else
          nil
        end
      end
    end
  end
end
