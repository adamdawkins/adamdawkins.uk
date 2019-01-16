class AddTwitterSilo < ActiveRecord::Migration[5.2]
  def up
    Silo.create(name: "Twitter", url: "https://twitter.com")
  end

  def down
    twitter_silo = Silo.find_by(name: "Twitter")
    twitter_silo.destroy if twitter_silo.present?
  end
end
