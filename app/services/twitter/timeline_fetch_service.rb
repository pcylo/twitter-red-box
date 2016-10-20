module Twitter
  class TimelineFetchService
    def initialize(user)
      raise UserMissingError unless user
      @user = user
      @twitter = user.twitter
    end

    def call
    end

    private

    attr_accessor :user, :twitter

    # max_id   - method returns results with an ID less than (that is, older than) or equal to the
    #            specified max_id identifier
    # since_id - method returns results with an ID greater than (that is, more recent than) the
    #            specified since_id
    def fetch_page(max_id: nil, since_id: nil, count: 200)
    end
  end

  class UserMissingError < StandardError; end
end
