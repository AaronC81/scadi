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
