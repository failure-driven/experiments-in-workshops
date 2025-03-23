# frozen_string_literal: true

require "rails_helper"

feature "User adds message to guestbook", :js do
  let(:guestbook) { Pages::GuestbookMessage.new }

  context "when there are existing guestbook entries" do
    before do
      Message.create!(name: "Gordon Great", text: "Presentation was great!")
      Message.create!(name: "Larry Learner", text: "Learnt a lot!")
      Message.create!(name: "Tyrel Tryer", text: "Can't wait to try these techniques at work!")
    end

    scenario "User adds message to guestbook" do
      When "the guestbook page is viewed" do
        guestbook.load
      end

      Then "the guestbook has existing messages" do
        expect(guestbook.messages_text).to eq([
          "Presentation was great!",
          "Learnt a lot!",
          "Can't wait to try these techniques at work!"
        ])
      end

      When "a new message is added missing the name" do
        guestbook.new_message.click
        guestbook.fill_in(
          text: "Finally understood the benefits fo testing first"
        )
        guestbook.submit!
      end

      Then "the visitor is told the message is successfully created" do
        expect(guestbook.message).to eq "Message was successfully created."
      end

      Then "the guestbook has the new message" do
        expect(guestbook).to have_messages(count: 4)
        expect(guestbook.messages_text).to include(
          "Finally understood the benefits fo testing first"
        )
      end
    end
  end
end
