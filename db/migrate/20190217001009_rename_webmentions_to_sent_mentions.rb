class RenameWebmentionsToSentMentions < ActiveRecord::Migration[5.2]
  def change
     rename_table :webmentions, :sent_mentions
  end
end
