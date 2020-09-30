Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :zoom, ENV['ZOOM_APP_KEY'], ENV['ZOOM_APP_SECRET']
  # provider :linkedin, 'consumer_key', 'consumer_secret'
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: 'user:email'
end
