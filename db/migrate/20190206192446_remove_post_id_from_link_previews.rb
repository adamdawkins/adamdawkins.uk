class RemovePostIdFromLinkPreviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :link_previews, :post_id
  end
end
