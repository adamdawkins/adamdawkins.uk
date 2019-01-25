class AddInReplyToToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :in_reply_to, :string
  end
end
