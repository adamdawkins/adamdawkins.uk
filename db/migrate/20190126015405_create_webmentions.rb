class CreateWebmentions < ActiveRecord::Migration[5.2]
  def change
    create_table :webmentions do |t|
      t.belongs_to :post, foreign_key: true
      t.string :target
      t.string :status

      t.timestamps
    end
  end
end
