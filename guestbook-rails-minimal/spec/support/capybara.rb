# frozen_string_literal: true

require "capybara-inline-screenshot/rspec"

Capybara.javascript_driver = :selenium_chrome

Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  if ENV.fetch("GITHUB_ACTIONS", nil) == "true" || ENV.fetch("CODESPACES", nil) == "true"
    options.add_argument("--headless")
    options.add_argument("--disable-gpu")
  end

  args = {browser: :chrome}
  args[:options] = options if options
  Capybara::Selenium::Driver.new(
    app,
    **args
  )
end

Capybara::Screenshot.register_driver(:selenium_chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end
