# == Schema Information
#
# Table name: tweets
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  identifier   :integer
#  text         :string
#  url          :string
#  author       :string
#  author_url   :string
#  author_image :string
#  added_at     :datetime
#  notes        :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_tweets_on_added_at    (added_at)
#  index_tweets_on_author      (author)
#  index_tweets_on_identifier  (identifier)
#  index_tweets_on_text        (text)
#  index_tweets_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_003928b7f5  (user_id => users.id)
#

class Tweet < ApplicationRecord
  belongs_to :user
end
