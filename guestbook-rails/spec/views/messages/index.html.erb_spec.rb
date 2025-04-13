require "rails_helper"

RSpec.describe "messages/index", type: :view do
  before do
    assign(:messages, [
      Message.create!(
        body: "MyText",
        name: "Name",
      ),
      Message.create!(
        body: "MyText",
        name: "Name",
      ),
    ],)
  end

  it "renders a list of messages" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new("MyText"), count: 2
    assert_select cell_selector, text: Regexp.new("Name"), count: 2
  end
end
