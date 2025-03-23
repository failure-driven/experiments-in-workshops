# frozen_string_literal: true

class Guestbook < SitePrism::Page
  include ::Pages::Helpers::FormsHelper[
    Rails.application.routes.url_helpers.entries_path,
    Entry.name.downcase
  ]

  set_url Rails.application.routes.url_helpers.entries_path

  element :new_entry, "a", text: "New entry"
  element :go_home, "a", text: "Back to entries"

  element :error_message, "form [data-testid=error-message]"

  sections :entries, ::Section::Entries, "#entries div[data-testid|=entry]"

  # TODO: strengthen matcher and switch to element
  def message
    find_all("p").first.text
  end

  def errors
    error_message.find_all("li").map(&:text)
  end

  def entries_text
    entries.map { _1.entry_text.text }
  end
end
