require 'rails_helper'

RSpec.describe "entries/edit", type: :view do
  let(:entry) {
    Entry.create!(
      title: "MyString",
      text: "MyString",
      name: "MyString"
    )
  }

  before(:each) do
    assign(:entry, entry)
  end

  it "renders the edit entry form" do
    render

    assert_select "form[action=?][method=?]", entry_path(entry), "post" do

      assert_select "input[name=?]", "entry[title]"

      assert_select "input[name=?]", "entry[text]"

      assert_select "input[name=?]", "entry[name]"
    end
  end
end
