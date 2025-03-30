require "rails_helper"

RSpec.describe GuestbookEntry do
  it "is valid" do
    guestbook_entry = GuestbookEntry.new(
      body: "the body",
      name: "the name"
    )
    expect(guestbook_entry).to be_valid
  end

  it "is not valid without body" do
    guestbook_entry = GuestbookEntry.new(
      body: "",
      name: "the name"
    )
    expect(guestbook_entry).not_to be_valid
  end

  it "is not valid without name" do
    guestbook_entry = GuestbookEntry.new(
      body: "the body",
      name: ""
    )
    expect(guestbook_entry).not_to be_valid
  end
end
