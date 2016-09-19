# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  uid        :string
#  token      :string
#  secret     :string
#  nickname   :string
#  name       :string
#  avatar     :string
#  url        :string
#  background :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_uid  (uid)
#

class User < ApplicationRecord

  def self.from_omniauth(auth_hash)
    where(uid: auth_hash.uid).first_or_initialize.tap do |user|
      user.name       = auth_hash.info.name,
      user.nickname   = auth_hash.info.nickname,
      user.token      = auth_hash.credentials.token,
      user.secret     = auth_hash.credentials.secret,
      user.avatar     = auth_hash.info.image,
      user.url        = auth_hash.info.urls.Twitter,
      user.background = auth_hash.extra.raw_info.profile_background_image_url_https
      user.save!
    end
  end

  def twitter
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = token
      config.access_token_secret = secret
    end
  end

end
