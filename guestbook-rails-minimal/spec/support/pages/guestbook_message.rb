# frozen_string_literal: true

require "support/pages/section/entries"

module Pages
  class GuestbookMessage < SitePrism::Page
    SETTABLE_ELEMENTS = ["datetime-local", "checkbox"].freeze

    set_url Rails.application.routes.url_helpers.messages_path

    element :new_message, "a", text: "New message"
    element :go_home, "a", text: "Back to messages"

    element :error_message, "form [data-testid=error-message]"

    sections :messages, "#messages div[data-testid|=message]" do
      element :message_text, "[data-testid=message-text]"
    end

    # TODO: strengthen matcher and switch to element
    def message
      find_all("p").first.text
    end

    def fill_in(**args)
      action = Rails.application.routes.url_helpers.messages_path
      model = "message"
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
      action = Rails.application.routes.url_helpers.messages_path
      fill_in(...)
      find("form[action^=\"#{action}\"] input[type=submit]").click
    end

    def check!
      click_on("check")
    end

    def errors
      error_message.find_all("li").map(&:text)
    end

    def messages_text
      messages.map { _1.message_text.text }
    end
  end
end
