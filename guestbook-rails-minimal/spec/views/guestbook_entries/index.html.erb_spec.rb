require "rails_helper"

RSpec.describe "guestbook_entries/index" do
  before do
    assign(:guestbook_entries, [
      GuestbookEntry.create!(
        body: "MyText",
        name: "Name"
      ),
      GuestbookEntry.create!(
        body: "MyText",
        name: "Name"
      )
    ])
  end

  it "renders a list of guestbook_entries" do
    render
    cell_selector = (Rails::VERSION::STRING >= "7") ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
  end
end
