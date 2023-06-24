module Scadi
  class STL
    Vector3 = Struct.new('Vector3', :x, :y, :z)
    Face = Struct.new('Face', :normal, :verteces)

    attr_reader :faces, :name, :metadata

    def initialize(path:)
      @faces = []

      content = File.read(path)
      parse_ascii_stl(content)
    end

    Extents = Struct.new('Extents', :minimums, :maximums) do
      def width  = maximums.x - minimums.x
      def depth  = maximums.y - minimums.y
      def height = maximums.z - minimums.z
    end

    def extents
      results = Extents.new(
        Vector3.new(Float::INFINITY, Float::INFINITY, Float::INFINITY),
        Vector3.new(-Float::INFINITY, -Float::INFINITY, -Float::INFINITY),
      )

      faces.each do |face|
        face.verteces.each do |vertex|
          # X
          results.minimums.x = vertex.x if vertex.x < results.minimums.x
          results.maximums.x = vertex.x if vertex.x > results.maximums.x

          # Y
          results.minimums.y = vertex.y if vertex.y < results.minimums.y
          results.maximums.y = vertex.y if vertex.y > results.maximums.y

          # Z
          results.minimums.z = vertex.z if vertex.z < results.minimums.z
          results.maximums.z = vertex.z if vertex.z > results.maximums.z
        end
      end

      results
    end

    protected def parse_ascii_stl(content)
      # Get the first line - only the first line break has a special meaning
      solid_header, faces_content = content.split("\n", 2)

      # Parse name and metadata
      raise "malformed STL: missing `solid` header" unless solid_header.start_with?('solid')
      _, solid_name, solid_metadata = solid_header.split(" ", 3)
      @name = solid_name
      @metadata = solid_metadata

      # Split rest of the file on whitespace, producing tokens
      tokens = faces_content.split

      # Utility functions for accessing tokens
      peek = ->{ tokens.first }
      take = ->t{ x = tokens.shift; raise "malformed STL: expected `#{t}`, got `#{x}`" unless x == t }
      take_float = ->{ Float(tokens.shift) }
      take_vector = ->{ Vector3.new(take_float.(), take_float.(), take_float.()) }

      # Parsing loop
      until peek.() == "endsolid"
        # Parse face with normal
        take.("facet")
        take.("normal")
        normal = take_vector.()

        # Parse vertices
        take.("outer")
        take.("loop")
        verteces = []
        3.times do 
          take.("vertex")
          verteces << take_vector.()
        end
        take.("endloop")

        # End face, and insert
        take.("endfacet")
        faces << Face.new(normal, verteces)
      end
    end
  end
end
