# frozen_string_literal: true

RSpec.feature "It works, root rails demo page", :js do
  let(:it_works_root) { ItWorksRoot.new }

  scenario "I have rails" do
    When "the root test page is visited" do
      it_works_root.load
    end

    Then "rails version is 8" do
      expect(
        it_works_root.rails_version.text,
      ).to match(/8/)
    end

    And "ruby version is 3.4.2" do
      expect(
        it_works_root.ruby_version.text,
      ).to match(/3.4.2/)
    end
  end
end
