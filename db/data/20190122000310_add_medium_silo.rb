class AddMediumSilo < ActiveRecord::Migration[5.2]
  def up
    Silo.create(name: "Medium", url: "https://medium.com")
  end

  def down
    Silo.find_by(name: "Medium").destroy
  end
end
