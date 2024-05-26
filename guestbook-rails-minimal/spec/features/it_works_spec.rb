# frozen_string_literal: true

require "rails_helper"

feature "It works, root rails demo page" do
  scenario "I have rails" do
    When "the root test page is visited" do
      visit test_root_rails_path
    end

    Then "rails version is 7.1" do
      expect(
        find("ul li", text: "Rails version").text
      ).to match(/7\.1\.\d+/)
    end

    And "ruby version is 3.2" do
      expect(
        find("ul li", text: "Ruby version").text
      ).to match(/3\.2\.\d+/)
    end
  end
end
