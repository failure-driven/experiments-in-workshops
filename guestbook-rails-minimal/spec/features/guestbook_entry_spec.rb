# frozen_string_literal: true

require "rails_helper"

feature "Guestbook entry gets added and viewed", :js do
  let(:guestbook) { Guestbook.new }

  scenario "Guestbook entry gets added and viewed" do
    When "the guestbook page is viewed" do
      guestbook.load
    end

    Then "the guestbook is empty" do
      expect(guestbook.entries).to be_empty
    end

    When "a new entry is added" do
      guestbook.new_entry.click
      guestbook.fill_in(
        title: "Amazing party",
        text: "Party on, this year and next 🎉",
        name: "Amazing Amy",
        date: Time.zone.now
      )
      guestbook.submit!
    end

    Then "the visitor is told the message is successfully created" do
      expect(guestbook.message).to eq "Entry was successfully created."
    end

    Then "the guestbook has the new message" do
      expect(guestbook.entries.map(&:text)).to match([
        /Party on, this year and next 🎉/
      ])
    end
  end
end
