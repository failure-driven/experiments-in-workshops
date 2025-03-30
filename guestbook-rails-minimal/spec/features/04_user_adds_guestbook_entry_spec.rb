# frozen_string_literal: true

ActiveJob::Base.queue_adapter = :test

feature "User adds guestbook entry", :js do
  include ActiveJob::TestHelper

  after do
    clear_enqueued_jobs
  end

  let(:guestbook) { Pages::GuestbookEntries.new }

  context "when there are existing guestbook entries" do
    before do
      GuestbookEntry.create!(name: "Gordon Great", body: "Presentation was great!")
      GuestbookEntry.create!(name: "Larry Learner", body: "Learnt a lot!")
      GuestbookEntry.create!(name: "Tyrel Tryer", body: "Can't wait to try these techniques at work!")
    end

    scenario "User adds guestbook entry" do
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
          body: "Finally understood the benefits fo testing first"
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
        expect(guestbook.notification).to eq "Guestbook entry was successfully created."
      end

      When "the user views all blogs" do
        guestbook.view_entries.click
      end

      Then "the guestbook has the new message" do
        expect(guestbook).to have_entries(count: 4)
        expect(guestbook.entries_text).to include(
          "Finally understood the benefits fo testing first"
        )
      end
    end

    scenario "User adds guestbook entry with AI generated body" do
      When "a new entry is added to the guestbook" do
        guestbook.load
        guestbook.new_entry.click
        guestbook.submit!(
          body: "Finally understood the benefits fo testing first",
          name: "Positive Patricia"
        )
      end

      Then "the visitor is told the message is successfully created" do
        expect(guestbook.notification).to eq "Guestbook entry was successfully created."
      end

      When "the user clicks generate AI text" do
        guestbook.generate_ai_body.click
      end

      Then "the user is notified that the AI is generating the text" do
        expect(guestbook.notification).to eq "AI text is being generated."
      end

      Then "When they refresh" do
        guestbook.refresh.click
      end

      Then "the user is still notified text generation is in progress" do
        expect(guestbook.notification).to eq "AI text is being generated."
      end

      When "AI has finished generating the response" do
        perform_enqueued_jobs
      end

      And "they refresh" do
        guestbook.refresh.click
      end

      Then "the generated AI text is displayed" do
        SitePrism::Waiter.wait_until_true {
          expect(page).to have_content "AI text successfully generated."
        }
        expect(guestbook.notification).to eq "AI text successfully generated."
        expect(guestbook.generated_ai_body).to have_text "AI GENERATED Finally understood the benefits fo testing first"
      end

      When "when the user continues with the update" do
        guestbook.update_generated_guestbook_entry.click
      end

      Then "the visitor sees the guestbook entry is updated" do
        SitePrism::Waiter.wait_until_true {
          expect(page).to have_content "Guestbook entry was successfully updated."
        }
        expect(guestbook.notification).to eq "Guestbook entry was successfully updated."
        expect(guestbook.entry_body).to have_text "AI GENERATED Finally understood the benefits fo testing first"
      end

      When "the user views all blogs" do
        guestbook.view_entries.click
      end

      Then "the guestbook has the new message" do
        expect(guestbook.entries_text).to include(
          "AI GENERATED Finally understood the benefits fo testing first"
        )
      end
    end
  end
end
