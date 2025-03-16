# frozen_string_literal: true

require "rails_helper"

ActiveJob::Base.queue_adapter = :test

feature "User adds entry to guestbook", :js do
  let(:guestbook) { Pages::GuestbookWithAI.new }

  context "when there are existing guestbook entries" do
    before do
      Entry.create!(name: "Gordon Great", text: "Presentation was great!")
      Entry.create!(name: "Larry Learner", text: "Learnt a lot!")
      Entry.create!(name: "Tyrel Tryer", text: "Can't wait to try these techniques at work!")
    end

    scenario "User adds entry to guestbook" do
      When "the guestbook page is viewed" do
        guestbook.load
      end

      Then "the guestbook has existing entries" do
        expect(guestbook.entries_text).to eq([
          "Presentation was great!",
          "Learnt a lot!",
          "Can't wait to try these techniques at work!"
        ])
      end

      When "a new entry is added missing the name" do
        guestbook.new_entry.click
        guestbook.fill_in(
          text: "Finally understood the benefits fo testing first"
        )
        guestbook.submit!
      end

      Then "the visitor is told there is an error as the name is blank" do
        expect(guestbook.errors).to eq(["Name can't be blank"])
      end

      When "the visitor submits their form with their name" do
        guestbook.fill_in(
          name: "Positive Patricia"
        )
        guestbook.submit!
      end

      Then "the visitor is told the message is successfully created" do
        expect(guestbook.message).to eq "Entry was successfully created."
      end

      Then "the guestbook has the new message" do
        expect(guestbook).to have_entries(count: 4)
        expect(guestbook.entries_text).to include(
          "Finally understood the benefits fo testing first"
        )
      end
    end

    scenario "User adds entry to guestbook with AI" do
      When "the guestbook page is viewed" do
        guestbook.load
      end

      # LAB 2 - START CODE - need to add fields for table and modle to handle AI generation and options etc
      When "a new entry is added" do
        guestbook.new_entry.click
        guestbook.fill_in(
          text: "like testing",
          name: "Positive Patricia",
          generate_ai_text: true
        )
        guestbook.submit!
      end

      Then "the visitor is told AI is generating the response" do
        expect(guestbook.message).to eq "AI is generating the response, please wait..."
      end
      # LAB 2 - END CODE

      When "AI has finised generating the response" do
        pending "need background jobs with sidekiq"
        # TODO: some kind of drain_all
        ActiveJob::Base.queue_adapter.enqueued_jobs.each do |job|
          ActiveJob::Base.execute(job)
        end
      end

      Then "the visitor is told the message is successfully created" do
        expect(guestbook.message).to eq "Entry was successfully created."
      end

      Then "the guestbook has the new message" do
        expect(guestbook).to have_entries(count: 4)
        expect(guestbook.entries_text).to include(
          "AI GENERATED like testing"
        )
      end
    end
  end
end
