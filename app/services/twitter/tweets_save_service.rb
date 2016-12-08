module Twitter
  class TweetsSaveService
    def initialize(user:)
      @user = user
    end

    def call(tweets:, type:)
      tweets.each do |tweet|
        user.tweets.where(identifier: tweet.identifier).first_or_initialize.tap do |new_tweet|
          new_tweet.text         = tweet.text
          new_tweet.url          = tweet.url
          new_tweet.author       = tweet.author
          new_tweet.author_url   = tweet.author_url
          new_tweet.author_image = tweet.author_image
          new_tweet.added_at     = tweet.added_at
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
