class CreateIndieMarkLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :indie_mark_levels do |t|
      t.string :name
      t.string :slug
      t.text :description

      t.timestamps
    end
    add_index :indie_mark_levels, :slug, unique: true
  end
end
