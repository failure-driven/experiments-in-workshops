RSpec.describe "messages/index" do
  before do
    assign(:messages, [
      Message.create!(
        text: "Text",
        name: "Name"
      ),
      Message.create!(
        text: "Text",
        name: "Name"
      )
    ])
  end

  it "renders a list of messages" do
    render
    cell_selector = (Rails::VERSION::STRING >= "7") ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new("Text".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
  end
end
