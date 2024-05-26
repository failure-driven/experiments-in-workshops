require "rails_helper"

RSpec.describe "entries/show" do
  before do
    assign(:entry, Entry.create!(
      title: "Title",
      text: "Text",
      name: "Name"
    ))
  end

  it "renders attributes in <p>", :aggregate_failures do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Text/)
    expect(rendered).to match(/Name/)
  end
end
