class AddAuthorPropertiesToLinkPreview < ActiveRecord::Migration[5.2]
  def change
    add_column :link_previews, :author_name, :string
    add_column :link_previews, :author_photo, :string
    add_column :link_previews, :author_url, :string
  end
end
