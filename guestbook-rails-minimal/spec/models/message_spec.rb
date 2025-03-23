require "rails_helper"

RSpec.describe Message do
  it "is valid" do
    message = Message.new(
      text: "the text",
      name: "the name"
    )
    expect(message).to be_valid
  end

  # it "is not valid without text" do
  #   message = Message.new(
  #     text: "",
  #     name: "the name"
  #   )
  #   expect(message).not_to be_valid
  # end

  # it "is not valid without name" do
  #   message = Message.new(
  #     text: "the text",
  #     name: ""
  #   )
  #   expect(message).not_to be_valid
  # end
end
