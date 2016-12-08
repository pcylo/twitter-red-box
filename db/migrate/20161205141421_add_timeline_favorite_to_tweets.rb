class AddTimelineFavoriteToTweets < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :timeline, :boolean, default: false
    add_index :tweets, :timeline
    add_column :tweets, :favorite, :boolean, default: false
    add_index :tweets, :favorite
  end
end
