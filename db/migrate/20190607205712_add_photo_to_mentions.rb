class AddPhotoToMentions < ActiveRecord::Migration[5.2]
  def change
    add_column :mentions, :photo, :string
  end
end
