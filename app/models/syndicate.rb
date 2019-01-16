class Syndicate < ApplicationRecord
  belongs_to :post
  belongs_to :silo

  validates :url, uniqueness: true, presence: true
end
