# frozen_string_literal: true

require "rails_helper"

feature "It works, root rails demo page" do
  let(:it_works_root) { ItWorksRoot.new }

  scenario "I have rails" do
    When "the root test page is visited" do
      it_works_root.load
    end

    Then "rails version is 7.1" do
      expect(
        it_works_root.rails_version.text
      ).to match(/7\.1\.\d+/)
    end

    And "ruby version is 3.2" do
      expect(
        it_works_root.ruby_version.text
      ).to match(/3\.2\.\d+/)
    end
  end
end
