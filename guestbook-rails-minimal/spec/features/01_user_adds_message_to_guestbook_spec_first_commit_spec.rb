# frozen_string_literal: true

ActiveJob::Base.queue_adapter = :test

feature "User adds message to guestbook", :js do
  include ActiveJob::TestHelper

  before do
    # TODO: this is actually to clear the jobs from some spec/request specs
    # triggering jobs - shoud do this in spec/rails_helper.rb
    clear_enqueued_jobs
  end

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

      Then "the visitor is told there is an error as the name is blank" do
        # pending "validation on name and text existing"
        expect(guestbook.errors).to eq(["Name can't be blank"])
      end

      When "the visitor submits their form with their name" do
        guestbook.fill_in(
          name: "Positive Patricia"
        )
        guestbook.submit!
      end

      And "AI has finished generating the response" do
        # TODO: is there some kind of built in test adapter drain_all?
        # ActiveJob::Base.queue_adapter.enqueued_jobs.each do |job|
        #   ActiveJob::Base.execute(job)
        # end
        perform_enqueued_jobs
        guestbook.check!
        SitePrism::Waiter.wait_until_true {
          expect(page).to have_no_content "AI generation complete"
        }
        guestbook.go_home.click
      end

      Then "the visitor is told the message is successfully created" do
        guestbook.when_loaded do |page|
          expect(page.message).to eq "Message was successfully created."
        end
      end

      Then "the guestbook has the new message" do
        expect(guestbook).to have_messages(count: 4)
        expect(guestbook.messages_text).to include(
          "AI GENERATED Finally understood the benefits fo testing first"
        )
      end
    end
  end
end
