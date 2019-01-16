class CreateSyndicates < ActiveRecord::Migration[5.2]
  def change
    create_table :syndicates do |t|
      t.belongs_to :post, foreign_key: true
      t.belongs_to :silo, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
