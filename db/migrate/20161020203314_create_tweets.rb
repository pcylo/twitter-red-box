class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.references :user, foreign_key: true
      t.integer :identifier, limit: 8
      t.string :text
      t.string :url
      t.string :author
      t.string :author_url
      t.string :author_image
      t.datetime :added_at
      t.text :notes

      t.timestamps
    end
    add_index :tweets, :identifier
    add_index :tweets, :text
    add_index :tweets, :author
    add_index :tweets, :added_at
  end
end
