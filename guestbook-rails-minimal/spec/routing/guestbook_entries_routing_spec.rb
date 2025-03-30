require "rails_helper"

RSpec.describe GuestbookEntriesController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/guestbook_entries").to route_to("guestbook_entries#index")
    end

    it "routes to #new" do
      expect(get: "/guestbook_entries/new").to route_to("guestbook_entries#new")
    end

    it "routes to #show" do
      expect(get: "/guestbook_entries/1").to route_to("guestbook_entries#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/guestbook_entries/1/edit").to route_to("guestbook_entries#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/guestbook_entries").to route_to("guestbook_entries#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/guestbook_entries/1").to route_to("guestbook_entries#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/guestbook_entries/1").to route_to("guestbook_entries#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/guestbook_entries/1").to route_to("guestbook_entries#destroy", id: "1")
    end
  end
end
