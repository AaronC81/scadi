M = Scadi::Model
V3 = Scadi::Vector3

describe "element" do
  it 'can convert to OpenSCAD code' do
    cube = M::Shapes::Cube.new(size: V3.new(10, 20, 30))
    expect(cube.to_openscad).to semantically_eq "cube([10, 20, 30]);"

    cube.modifiers << M::Modifiers::Translate.new(offset: V3.new(1, 2, 3))
    expect(cube.to_openscad).to semantically_eq "
      translate([1, 2, 3])
      cube([10, 20, 30]);
    "

    union = M::Operations::Union.new()
    3.times do
      union << cube.dup
    end
    expect(union.to_openscad).to semantically_eq "
      union() {
        translate([1, 2, 3]) cube([10, 20, 30]);
        translate([1, 2, 3]) cube([10, 20, 30]);
        translate([1, 2, 3]) cube([10, 20, 30]);
      }
    "
  end
end
