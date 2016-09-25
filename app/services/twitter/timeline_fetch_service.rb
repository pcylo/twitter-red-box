module Twitter
  #
  # max_id   - Returns results with an ID less than (that is, older than) or equal to the specified
  #            identifier
  # since_id - Returns results with an ID greater than (that is, more recent than) the specified ID
  #
  class TimelineFetchService
    def initialize(user)
      raise UserMissingError unless user
      @user = user
    end

    def call(max_id: nil, since_id: nil, count: 200)

    private

    attr_accessor :user

  end

  class UserMissingError < StandardError; end
end
