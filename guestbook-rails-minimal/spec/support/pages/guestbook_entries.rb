# frozen_string_literal: true

module Pages
  class GuestbookEntries < SitePrism::Page
    include Helpers::FormsHelper[
      Rails.application.routes.url_helpers.guestbook_entries_path,
      GuestbookEntry.name.underscore
    ]

    set_url Rails.application.routes.url_helpers.guestbook_entries_path

    element :new_entry, "a", text: "New guestbook entry"
    element :edit_blog, "a", text: "Edit this guestbook entry"
    element :go_home, "a", text: "Back to entries"
    element :view_entries, "a", text: "Back to guestbook entries"
    element :destroy_entry, "button[type=submit]", text: "Destroy this guestbook entry"

    element :generate_ai_body, "[data-testid=generate-ai-body]"
    element :update_generated_guestbook_entry, "[data-testid=update-generated-guestbook-entry]"
    element :generated_ai_body, "[data-testid=generated-ai-body]"

    element :refresh, "[data-testid=refresh]"

    element :error_message, "form [data-testid=error-message]"

    element :entry_body, "[data-testid=body]"

    sections :entries, "#guestbook_entries div[id^=guestbook_entry_]" do
      element :entry_body, "[data-testid=body]"
    end

    def notification
      find_all("p").first.text
    end

    def errors
      error_message.find_all("li").map(&:text)
    end

    def entries_text
      entries.map { _1.entry_body.text }
    end
  end
end
