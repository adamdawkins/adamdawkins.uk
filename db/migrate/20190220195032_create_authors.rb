class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :uid
      t.string :name
      t.string :url
      t.string :nickname
      t.string :photo

      t.timestamps
    end
  end
end
