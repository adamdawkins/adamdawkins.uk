class LinkPreview < ApplicationRecord
  validates :url, presence: true, uniqueness: true
  validates :title, presence: true

  def self.from_url(url)
    where(url: url).first_or_initialize.tap do |link_preview|
      # use our database version if we've checked in it the last 7 days
      return link_preview if link_preview.persisted? &&
                             link_preview.updated_at > 7.days.ago

      preview = LinkPreviewGenerator.new(url).to_hash
      next if preview.blank?

      preview.each do |key, value|
        link_preview[key] = value
      end
      link_preview.save!
    end
  end
end
