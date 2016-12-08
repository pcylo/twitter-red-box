module Twitter
  class TweetsFetchService
    DEFAULT_LOOP_LIMIT = ENV['LOOP_LIMIT'].blank? ? 1000 : ENV['LOOP_LIMIT']
    DEFAULT_PAGE_SIZE = ENV['PAGE_SIZE'].blank? ? 200 : ENV['PAGE_SIZE']
    VALID_TYPES = [:timeline, :favorite]

    def initialize(user:)
      @user = user
      @twitter = user.twitter
      @tweets_save_service = Twitter::TweetsSaveService.new(user: @user)
    end

    def call(type)
      raise UnknownTweetTypeError unless VALID_TYPES.include? type

      load_existing_tweets(type)

      # TODO: set progress marker on the user instance
      fetch_first(type) unless @existing_tweets.any?

      fetch_older_than_existing(type)
      fetch_newer_than_existing(type)
    ensure
      # TODO: unset progress marker on the user
    end

    private

    attr_accessor :user, :twitter, :tweets_save_service

    def load_existing_tweets(type)
      @existing_tweets = user.tweets.send(type.to_s).pluck(:identifier)
      @oldest_id, @recent_id = @existing_tweets.minmax
    end

    def fetch_older_than_existing(type)
      loop_counter = 0
      loop do
        loop_counter += 1
        Rails.logger.info("Fetching tweets older than #{@oldest_id} for #{user.nickname}")
        results = fetch_page(type: type, max_id: @oldest_id)
        tweets_save_service.call(tweets: results, type: type)
        load_existing_tweets(type)
        break if results.count < DEFAULT_PAGE_SIZE || loop_counter > DEFAULT_LOOP_LIMIT
      end
    end

    def fetch_newer_than_existing(type)
      loop_counter = 0
      loop do
        loop_counter += 1
        Rails.logger.info("Fetching tweets newer than #{@recent_id} for #{user.nickname}")
        results = fetch_page(type: type, since_id: @recent_id)
        tweets_save_service.call(tweets: results, type: type)
        load_existing_tweets(type)
        break if results.count < DEFAULT_PAGE_SIZE || loop_counter > DEFAULT_LOOP_LIMIT
      end
    end

    def fetch_first(type)
      Rails.logger.info("Fetching first tweets for #{user.nickname}")
      results = fetch_page(type: type)
      tweets_save_service.call(tweets: results, type: type)
      load_existing_tweets(type)
    end

    # max_id   - method returns results with an ID less than (that is, older than) or equal to the
    #            specified max_id identifier
    # since_id - method returns results with an ID greater than (that is, more recent than) the
    #            specified since_id identifier
    def fetch_page(type:, max_id: nil, since_id: nil)
      case type
      when :timeline
        twitter.user_timeline(build_parameters(max_id, since_id, DEFAULT_PAGE_SIZE))
      when :favorite
        twitter.favorites(build_parameters(max_id, since_id, DEFAULT_PAGE_SIZE))
      end
    end

    def build_parameters(max_id, since_id, count)
      parameters = { count: DEFAULT_PAGE_SIZE }
      parameters[:max_id] = max_id if max_id
      parameters[:since_id] = since_id if since_id
      parameters
    end
  end

  class UnknownTweetTypeError < StandardError; end
end
