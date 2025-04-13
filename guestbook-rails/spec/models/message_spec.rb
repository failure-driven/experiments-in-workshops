# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  body       :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
RSpec.describe Message, type: :model do
  it "is valid" do
    message = Message.new(
      body: "the body",
      name: "the name",
    )
    expect(message).to be_valid
  end
end
