# frozen_string_literal: true

require "support/pages/section/entries"

module Pages
  class GuestbookWithAIFull < SitePrism::Page
    SETTABLE_ELEMENTS = ["datetime-local", "checkbox"].freeze

    set_url Rails.application.routes.url_helpers.guestbook_with_ai_full_root_path

    element :new_entry, "a", text: "New entry"
    element :go_home, "a", text: "Back to entries"

    element :error_message, "form [data-testid=error-message]"

    sections :entries, ::Section::Entries, "#entries div[data-testid|=entry]"

    # TODO: strengthen matcher and switch to element
    def message
      find_all("p").first.text
    end

    def fill_in(**args)
      action = Rails.application.routes.url_helpers.guestbook_with_ai_full_entries_path
      model = "entry"
      args.each do |field, value|
        element = find("form[action^=\"#{action}\"] input[name=\"#{model}[#{field}]\"]")
        if SETTABLE_ELEMENTS.include? element[:type]
          element.set(value)
        else
          element.fill_in(with: value)
        end
      end
    end

    def submit!(...)
      action = Rails.application.routes.url_helpers.guestbook_with_ai_full_entries_path
      fill_in(...)
      find("form[action^=\"#{action}\"] input[type=submit]").click
    end

    def check!
      click_on("check")
    end

    def errors
      error_message.find_all("li").map(&:text)
    end

    def entries_text
      entries.map { _1.entry_text.text }
    end
  end
end
