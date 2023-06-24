module Scadi
  Vector3 = Struct.new('Vector3', :x, :y, :z) do
    def to_openscad = "[ #{x}, #{y}, #{z} ]"
  end

  module Util
    module Abstract
      def abstract! = raise("abstract method")
    end
  end
end
