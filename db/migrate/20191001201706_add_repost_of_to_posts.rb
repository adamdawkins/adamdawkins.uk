class AddRepostOfToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :repost_of, :string
  end
end
