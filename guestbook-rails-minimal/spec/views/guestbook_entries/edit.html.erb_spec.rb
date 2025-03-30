require "rails_helper"

RSpec.describe "guestbook_entries/edit" do
  let(:guestbook_entry) {
    GuestbookEntry.create!(
      body: "MyText",
      name: "MyString"
    )
  }

  before do
    assign(:guestbook_entry, guestbook_entry)
  end

  it "renders the edit guestbook_entry form" do
    render

    assert_select "form[action=?][method=?]", guestbook_entry_path(guestbook_entry), "post" do
      assert_select "textarea[name=?]", "guestbook_entry[body]"

      assert_select "input[name=?]", "guestbook_entry[name]"
    end
  end
end
