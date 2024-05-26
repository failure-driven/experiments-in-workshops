# frozen_string_literal: true

require "capybara-inline-screenshot/rspec"

Capybara.javascript_driver = :selenium_chrome

Capybara::Screenshot.register_driver(:selenium_chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end
