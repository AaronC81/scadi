# TODO: make an actual test

describe "DSL" do
  it "works" do
    Scadi::DSL.use do
      union do
        cube(1, 2, 3).translate(5, 10, 15)
        cube(4, 5, 6)
      end
    end
  end
end
