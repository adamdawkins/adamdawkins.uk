class CreateMentions < ActiveRecord::Migration[5.2]
  def change
    create_table :mentions do |t|
      t.belongs_to :post, foreign_key: true
      t.string :source
      t.string :title
      t.string :content
      t.string :in_reply_to

      t.timestamps
    end
  end
end
