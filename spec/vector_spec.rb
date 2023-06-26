describe Scadi::Vector3 do
  it "implements #from_array appropriately" do
    expect(V3.from_array [3]).to eq V3.new(3, 3, 3)
    expect(V3.from_array [1, 2]).to eq V3.new(1, 2, 0)
    expect(V3.from_array [1, 2, 3]).to eq V3.new(1, 2, 3)
    expect { V3.from_array [] }.to raise_exception(RuntimeError)
    expect { V3.from_array [1, 2, 3, 4] }.to raise_exception(RuntimeError)
  end
end

describe Scadi::Vector2 do
  it "implements #from_array appropriately" do
    expect(V2.from_array [3]).to eq V2.new(3, 3)
    expect(V2.from_array [1, 2]).to eq V2.new(1, 2)
    expect { V2.from_array [] }.to raise_exception(RuntimeError)
    expect { V2.from_array [1, 2, 3] }.to raise_exception(RuntimeError)
  end
end
