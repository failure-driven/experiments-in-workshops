require "rails_helper"

RSpec.describe "messages/show" do
  before do
    assign(:message, Message.create!(
      text: "Text",
      name: "Name"
    ))
  end

  it "renders attributes in <p>", :aggregate_failures do
    render
    expect(rendered).to match(/Text/)
    expect(rendered).to match(/Name/)
  end
end
