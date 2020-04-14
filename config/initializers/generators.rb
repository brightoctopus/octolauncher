Rails.application.config.generators do |g|
  # Disable generators we don't need.
  g.javascripts     false
  g.system_tests    false
  g.stylesheets     false
  g.helper          false
end