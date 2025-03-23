RSpec.describe "entries/edit" do
  let(:entry) {
    Entry.create!(
      title: "MyString",
      text: "MyString",
      name: "MyString"
    )
  }

  before do
    assign(:entry, entry)
  end

  it "renders the edit entry form" do # rubocop:disable RSpec/ExampleLength
    render

    assert_select "form[action=?][method=?]", entry_path(entry), "post" do
      assert_select "input[name=?]", "entry[title]"

      assert_select "input[name=?]", "entry[text]"

      assert_select "input[name=?]", "entry[name]"
    end
  end
end
