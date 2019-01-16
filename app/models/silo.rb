class Silo < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :url, uniqueness: true, presence: true

  has_many :syndicates
end
