require "rails_helper"

RSpec.describe "guestbook_entries/new" do
  before do
    assign(:guestbook_entry, GuestbookEntry.new(
      body: "MyText",
      name: "MyString"
    ))
  end

  it "renders new guestbook_entry form" do
    render

    assert_select "form[action=?][method=?]", guestbook_entries_path, "post" do
      assert_select "textarea[name=?]", "guestbook_entry[body]"

      assert_select "input[name=?]", "guestbook_entry[name]"
    end
  end
end
