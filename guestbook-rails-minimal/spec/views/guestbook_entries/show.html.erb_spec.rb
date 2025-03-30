require "rails_helper"

RSpec.describe "guestbook_entries/show" do
  before do
    assign(:guestbook_entry, GuestbookEntry.create!(
      body: "MyText",
      name: "Name"
    ))
  end

  it "renders attributes in <p>", :aggregate_failures do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Name/)
  end
end
