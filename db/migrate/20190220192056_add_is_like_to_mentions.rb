class AddIsLikeToMentions < ActiveRecord::Migration[5.2]
  def change
    add_column :mentions, :is_like, :boolean, default: false
  end
end
