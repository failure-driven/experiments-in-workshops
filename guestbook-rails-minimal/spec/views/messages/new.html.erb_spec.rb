RSpec.describe "messages/new" do
  before do
    assign(:message, Message.new(
      text: "MyString",
      name: "MyString"
    ))
  end

  it "renders new message form" do
    render

    assert_select "form[action=?][method=?]", messages_path, "post" do
      assert_select "input[name=?]", "message[text]"

      assert_select "input[name=?]", "message[name]"
    end
  end
end
