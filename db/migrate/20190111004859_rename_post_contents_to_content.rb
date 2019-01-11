class RenamePostContentsToContent < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :contents, :content
  end
end
