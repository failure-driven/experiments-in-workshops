# frozen_string_literal: true

require "rails_helper"

feature "It works, root rails demo page" do
  scenario "I have rails" do
    visit test_root_rails_path

    expect(
      find("ul li", text: "Rails version").text
    ).to match(/7\.1\.\d+/)
    expect(
      find("ul li", text: "Ruby version").text
    ).to match(/3\.2\.\d+/)
  end
end
