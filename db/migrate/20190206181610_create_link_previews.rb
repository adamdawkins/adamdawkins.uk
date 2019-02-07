class CreateLinkPreviews < ActiveRecord::Migration[5.2]
  def change
    create_table :link_previews do |t|
      t.string :url
      t.string :title
      t.string :description
      t.string :image
      t.belongs_to :post, foreign_key: true

      t.timestamps
    end
  end
end
