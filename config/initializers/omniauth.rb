OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'],
    {
      :secure_image_url => 'true',
      :image_size => 'bigger'
    }
end
