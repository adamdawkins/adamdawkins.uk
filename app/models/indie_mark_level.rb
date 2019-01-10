class IndieMarkLevel < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :indie_mark_items, dependent: :destroy

  def score
    indie_mark_items.completed.sum(&:score)
  end
end
