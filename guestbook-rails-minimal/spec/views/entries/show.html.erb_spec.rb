require 'rails_helper'

RSpec.describe "entries/show", type: :view do
  before(:each) do
    assign(:entry, Entry.create!(
      title: "Title",
      text: "Text",
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Text/)
    expect(rendered).to match(/Name/)
  end
end
