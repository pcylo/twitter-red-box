class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :token
      t.string :secret
      t.string :nickname
      t.string :name
      t.string :avatar
      t.string :url
      t.string :background

      t.timestamps
    end
    add_index :users, :uid
  end
end
