M = Scadi::Model
V3 = Scadi::Vector3

describe "element" do
  it 'can convert to OpenSCAD code' do
    cube = M::Shapes::Cube.new(size: V3.new(10, 20, 30))
    expect(cube.to_openscad).to semantically_eq "cube([10, 20, 30]);"

    cube.modifiers << M::Modifiers::Transform.new(offset: V3.new(1, 2, 3))
    expect(cube.to_openscad).to semantically_eq "
      transform([1, 2, 3])
      cube([10, 20, 30]);
    "

    union = M::Operations::Union.new()
    union << new_cube
    expect(union.to_openscad).to semantically_eq "
      union() {
        transform([1, 2, 3]) cube([10, 20, 30]);
        transform([1, 2, 3]) cube([10, 20, 30]);
        transform([1, 2, 3]) cube([10, 20, 30]);
      }
    "
  end
end
