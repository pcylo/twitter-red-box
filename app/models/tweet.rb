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
#  timeline     :boolean          default(FALSE)
#  favorite     :boolean          default(FALSE)
#
# Indexes
#
#  index_tweets_on_added_at    (added_at)
#  index_tweets_on_author      (author)
#  index_tweets_on_favorite    (favorite)
#  index_tweets_on_identifier  (identifier)
#  index_tweets_on_text        (text)
#  index_tweets_on_timeline    (timeline)
#  index_tweets_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_003928b7f5  (user_id => users.id)
#

class Tweet < ApplicationRecord
  belongs_to :user

  validate :timeline_or_favorite

  scope :timeline, -> { where(timeline: true) }
  scope :favorite, -> { where(favorite: true) }

  def timeline_or_favorite
    unless timeline || favorite
      errors.add(:base, "Tweet must be marked as timeline, favorite or both")
    end
  end
end
