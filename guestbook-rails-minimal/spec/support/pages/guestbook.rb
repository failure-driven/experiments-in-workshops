# frozen_string_literal: true

class Guestbook < SitePrism::Page
  set_url Rails.application.routes.url_helpers.root_path

  element :new_entry, "a", text: "New entry"
  element :go_home, "a", text: "Back to entries"

  # TODO: switch to sub element
  elements :entries, "#entries div"

  # TODO: strengthen matcher and switch to element
  def message
    find_all("p").first.text
  end

  def fill_in(**args)
    action = Rails.application.routes.url_helpers.entries_path
    model = "entry"
    args.each do |field, value|
      element = find("form[action=\"#{action}\"] input[name=\"#{model}[#{field}]\"]")
      if element[:type] == "datetime-local"
        element.set(value)
      else
        element.fill_in(with: value)
      end
    end
  end

  def submit!(...)
    action = Rails.application.routes.url_helpers.entries_path
    fill_in(...)
    find("form[action=\"#{action}\"] input[type=submit]").click
  end
end
