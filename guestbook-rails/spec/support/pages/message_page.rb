# frozen_string_literal: true

module Pages
  class MessagePage < SitePrism::Page
    # set_url Rails.application.routes.url_helpers.messages_path
    set_url "/messages"

    include Helpers::FormsHelper[
      "/messages", # Rails.application.routes.url_helpers.messages_path,
      "message" # Message.name.downcase
    ]

    element :new_message, "a", text: "New message"
    element :edit_message, "a", text: "Edit this message"
    element :view_messages, "a", text: "Back to messages"
    element :destroy_message, "button[type=submit]", text: "Destroy this message"

    element :body, "[id^=message_] p", text: "Body:"
    element :name, "[id^=message_] p", text: "Name:"

    sections :posts, "div#messages div[id^=message_]" do
      element :message_text, "p"
    end

    def notification
      # NOTE: rails success messge is
      #   <p style=\"color: green\">Blog was successfully created.</p>
      # Presumably failure message is
      #   <p style=\"color: red\">Unprocessable operation.</p>
      find_all("p").first.text
    end

    def posts_text
      posts.map { _1.text }
    end

    def show_message!(number)
      page.find_all("a", text: "Show this message")[number - 1].click
    end
  end
end
