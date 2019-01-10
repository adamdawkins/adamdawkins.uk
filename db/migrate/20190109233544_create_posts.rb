class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :type
      t.text :contents
      t.datetime :published_at
      t.string :permalink
      t.integer :sequence

      t.timestamps
    end
    add_index :posts, :permalink, unique: true
  end
end
