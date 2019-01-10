class CreateIndieMarkItems < ActiveRecord::Migration[5.2]
  def change
    create_table :indie_mark_items do |t|
      t.string :title
      t.text :details
      t.datetime :completed_at
      t.decimal :score
      t.belongs_to :indie_mark_level, foreign_key: true

      t.timestamps
    end
  end
end
