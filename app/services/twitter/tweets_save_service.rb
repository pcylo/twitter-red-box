module Twitter
  class TweetsSaveService
    def initialize(user:)
      @user = user
    end

    def call(tweets:, type:)
      tweets.each do |tweet|
        user.tweets.where(identifier: tweet.id).first_or_initialize.tap do |new_tweet|
          new_tweet.text         = tweet.full_text
          new_tweet.author       = tweet.user.screen_name
          new_tweet.author_image = tweet.user.profile_image_url.to_s.gsub('_normal.', '_bigger.')
          new_tweet.added_at     = tweet.created_at
          new_tweet.timeline     = true if type == :timeline
          new_tweet.favorite     = true if type == :favorite
          new_tweet.save!
        end
      end
    end

    private

    attr_accessor :user
  end
end
