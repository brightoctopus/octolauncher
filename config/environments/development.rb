mailer_regex = /config\.action_mailer\.raise_delivery_errors = false\n/

if @default_options[:devise] || @default_options[:mailcatcher]
  url_options = <<-RUBY
    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  RUBY
end

if @default_options[:mailcatcher]
  mailcatcher_config = <<-RUBY
    # Use Mailcatcher in development
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = { address: 'localhost', port: 1025 }
    config.action_mailer.asset_host = 'http://localhost:3000'
  RUBY
end

if @default_options[:rspec]
  rspec_config = <<-RUBY
    # Use RSpec to preview mailers
    config.action_mailer.preview_path = Rails.root.join('spec/mailers/previews')
  RUBY
end

comment_lines "config/environments/development.rb", mailer_regex
insert_into_file "config/environments/development.rb", after: mailer_regex do
  <<-RUBY
    #{url_options}
    #{mailcatcher_config}
    #{rspec_config}
  RUBY
end

if @default_options[:bullet]
  insert_into_file 'config/environments/development.rb', before: /^end/ do
    <<-RUBY
    # Bullet gem configuration.
    config.after_initialize do
      Bullet.enable = true
      Bullet.alert = true
      Bullet.bullet_logger = true
      Bullet.console = true
  
      Bullet.rails_logger = false
      Bullet.honeybadger = false
      Bullet.bugsnag = false
      Bullet.airbrake = false
  
      # Bullet.slack = { webhook_url: 'http://some.slack.url', channel: '#default', username: 'notifier' }
    end
    RUBY
  end
end