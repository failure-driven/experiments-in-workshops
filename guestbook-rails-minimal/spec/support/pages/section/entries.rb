# frozen_string_literal: true

module Section
  class Entries < SitePrism::Section
    element :entry_text, "[data-testid=entry-text]"
  end
end
