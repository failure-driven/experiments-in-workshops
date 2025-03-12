require "rails_helper"

RSpec.describe Entry do
  it "is valid" do
    entry = Entry.new(
      title: "the title",
      text: "the text",
      name: "the name",
      date: Time.zone.now
    )
    expect(entry).to be_valid
  end

  it "is not valid without text" do
    entry = Entry.new(
      title: "the title",
      text: "",
      name: "the name",
      date: Time.zone.now
    )
    expect(entry).not_to be_valid
  end

  it "is not valid without name" do
    entry = Entry.new(
      title: "the title",
      text: "the text",
      name: "",
      date: Time.zone.now
    )
    expect(entry).not_to be_valid
  end
end
