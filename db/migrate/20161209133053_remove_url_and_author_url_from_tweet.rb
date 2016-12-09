class RemoveUrlAndAuthorUrlFromTweet < ActiveRecord::Migration[5.0]
  def change
    remove_column :tweets, :url
    remove_column :tweets, :author_url
  end
end
