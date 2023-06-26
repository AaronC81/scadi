module Scadi
  Vector3 = Struct.new('Vector3', :x, :y, :z) do
    def to_openscad = "[ #{x}, #{y}, #{z} ]"

    def self.from_array(arr)
      return arr if arr.is_a?(Vector3)

      case arr
      in [v]
        Vector3.new(v, v, v)
      in [x, y]
        Vector3.new(x, y, 0)
      in [x, y, z]
        Vector3.new(x, y, z)
      else
        raise "invalid Vector3: #{arr}"
      end
    end
  end

  Vector2 = Struct.new('Vector2', :x, :y) do
    def to_openscad = "[ #{x}, #{y} ]"

    def self.from_array(arr)
      return arr if arr.is_a?(Vector2)

      case arr
      in [v]
        Vector2.new(v, v)
      in [x, y]
        Vector2.new(x, y)
      else
        raise "invalid Vector2: #{arr}"
      end
    end
  end

  module Util
    module Abstract
      def abstract! = raise("abstract method")
    end
  end
end
