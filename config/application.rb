insert_into_file 'config/application.rb', before: /^  end/ do
  <<-'RUBY'
    config.generators do |g|
      g.test_framework :rspec
      g.system_tests    false
      g.stylesheets     false
      g.helper          false
    end

    # Use sidekiq to process Active Jobs (e.g. ActionMailer's deliver_later)
    config.active_job.queue_adapter = :sidekiq
  RUBY
end
