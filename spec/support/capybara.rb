# frozen_string_literal: true

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w[headless disable-gpu no-sandbox disable-dev-shm-usage]
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :headless_chrome

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium, using: :headless_chrome
  end
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    if ENV['SELENIUM_URL'].present?
      # Make the test app listen to outside requests, for the remote Selenium instance.
      Capybara.server_host = '0.0.0.0'

      # Specify the driver
      driven_by :selenium, using: :headless_chrome,
                           screen_size: [1280, 1024],
                           options: { url: ENV['SELENIUM_URL'] }

      # Get the application container's IP
      ip = Socket.ip_address_list.detect(&:ipv4_private?).ip_address

      # Use the IP instead of localhost so Capybara knows where to direct Selenium
      host! "http://#{ip}:#{Capybara.server_port}"
    else
      # Otherwise, use the local machine's chromedriver
      driven_by :selenium, using: :headless_chrome
    end
  end
end
