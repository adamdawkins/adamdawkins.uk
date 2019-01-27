class Syndicate < ApplicationRecord
  belongs_to :post
  belongs_to :silo
  before_destroy :delete_post_from_silo

  validates :url, uniqueness: true, presence: true

  def delete_post_from_silo
    pp "Checking for silo posts to destroy"
    TwitterService.destroy(url) if silo.name == "Twitter"
  end
end
