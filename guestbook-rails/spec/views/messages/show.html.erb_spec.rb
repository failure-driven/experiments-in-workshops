require "rails_helper"

RSpec.describe "messages/show", type: :view do
  before do
    assign(:message, Message.create!(
      body: "MyText",
      name: "Name",
    ),)
  end

  it "renders attributes in <p>", :aggregate_failures do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Name/)
  end
end
