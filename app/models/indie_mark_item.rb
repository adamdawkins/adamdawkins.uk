class IndieMarkItem < ApplicationRecord
  belongs_to :indie_mark_level

  scope :completed, -> { where.not(completed_at: nil) }

  def completed?
    completed_at.present?
  end
end
