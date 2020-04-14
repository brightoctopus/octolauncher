# frozen_string_literal: true

url = ENV['REDIS_URL']

if url
  Sidekiq.configure_server do |config|
    config.redis = { url: url }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: url }
  end

  $redis = Redis.new(url: url)
else
  $redis = Redis.new
end
