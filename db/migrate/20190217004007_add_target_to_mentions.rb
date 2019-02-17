class AddTargetToMentions < ActiveRecord::Migration[5.2]
  def change
    add_column :mentions, :target, :string
  end
end
