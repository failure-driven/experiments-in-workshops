RSpec.describe "entries/index" do
  before do
    assign(:entries, [
      Entry.create!(
        title: "Title",
        text: "Text",
        name: "Name"
      ),
      Entry.create!(
        title: "Title",
        text: "Text",
        name: "Name"
      )
    ])
  end

  it "renders a list of entries" do
    render
    cell_selector = (Rails::VERSION::STRING >= "7") ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Text".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
  end
end
