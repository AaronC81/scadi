module Scadi
  Vector3 = Struct.new('Vector3', :x, :y, :z)

  module Util
    module Abstract
      def abstract! = raise("abstract method")
    end
  end
end
