class AddDragondropSilo < ActiveRecord::Migration[5.2]
  def up
    Silo.create(name: "Dragon Drop", url: "https://dragondrop.uk")
  end

  def down
    Silo.find_by(name: "Dragon Drop").destroy
  end
end
