describe "custom matchers" do
  it 'has `semantically_eq`' do
    expect("a   b c    d  ").to semantically_eq "abcd"
    expect("ab   cd").to semantically_eq "   a   b c\n d"
    expect("a  b c  d").not_to semantically_eq "a   b c  "
  end
end
