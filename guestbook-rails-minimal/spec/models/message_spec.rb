require "rails_helper"

RSpec.describe Message do
  it "is valid" do
    entry = Message.new(
      text: "the text",
      name: "the name"
    )
    expect(entry).to be_valid
  end
end
