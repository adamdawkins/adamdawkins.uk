class RemovePermalinkFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :permalink, :string
  end
end
