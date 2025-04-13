# frozen_string_literal: true

RSpec.feature "Demonstrate message CRUD methods", :js do
  let(:message_page) { Pages::MessagePage.new }

  scenario "A message is empty and new message posts can be generated" do
    When "the message is visited" do
      message_page.load
    end

    Then "there are no message posts" do
      expect(message_page.posts(wait: 0)).to be_empty
    end

    When "a new post is created" do
      message_page.new_message.click
      message_page.submit!(
        body: "message body",
        name: "message name",
      )
    end

    Then "the user is notified the message was created" do
      expect(message_page.notification).to eq "Message was successfully created."
    end

    And "the message has the expected fields" do
      expect(message_page.body).to have_text "message body"
      expect(message_page.name).to have_text "message name"
    end

    When "the user edits a field" do
      message_page.edit_message.click
      message_page.submit!(
        body: "message body that has been modified",
      )
    end

    Then "the user is notified the message was updated" do
      expect(message_page.notification).to eq "Message was successfully updated."
      expect(message_page.body).to have_text "message body that has been modified"
    end

    When "the user views all messages" do
      message_page.view_messages.click
    end

    Then "their 1 message is displayed" do
      expect(message_page.posts.length).to eq 1
      expect(message_page.posts_text).to eq(
        [
          <<~EO_MESSAGE_CONTENT.chomp,
            Body: message body that has been modified
            Name: message name
          EO_MESSAGE_CONTENT
        ],
      )
    end

    When "the user views and destroys the message" do
      message_page.show_message!(1)
      message_page.destroy_message.click
    end

    Then "the user is notified the message was updated" do
      expect(page).to have_text "Message was successfully destroyed."
      expect(message_page.notification).to eq "Message was successfully destroyed."
    end

    And "there are no messages" do
      expect(message_page.posts).to be_empty
    end
  end
end
