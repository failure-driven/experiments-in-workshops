# frozen_string_literal: true

module Pages
  class GuestbookMessage < SitePrism::Page
    include Helpers::FormsHelper[
      Rails.application.routes.url_helpers.messages_path,
      Message.name.downcase
    ]

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
