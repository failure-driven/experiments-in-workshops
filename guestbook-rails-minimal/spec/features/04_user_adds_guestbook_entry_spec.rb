# frozen_string_literal: true

feature "User adds guestbook entry", :js do
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
  end
end
