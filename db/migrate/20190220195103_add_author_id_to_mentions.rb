class AddAuthorIdToMentions < ActiveRecord::Migration[5.2]
  def change
    add_column :mentions, :author_id, :integer
  end
end
