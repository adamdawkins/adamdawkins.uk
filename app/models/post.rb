require "securerandom"

class SlugValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:slug] << 'needs to be unique on the published date' if record.new_record? && record.slug_already_exists?
  end
end

class Post < ApplicationRecord
  validates_presence_of :content
  validates_with SlugValidator
  before_validation :generate_slug

  scope :published, -> { where("published_at IS NOT NULL").order("published_at DESC") }

  def long_url_params
    [self.published_at.year,
     self.published_at.strftime('%m'),
     self.published_at.strftime('%d'),
     self.sequence
    ]
  end

  def params
    { year: published_at.year, month: published_at.month, day: published_at.day, slug: slug }
  end

  def slug_candidates
    [ ->(post) {
        post.slug
      },
      ->(post) {
        post.title
      },
      ->(post) {
        post.content[0, 150] if post.content.present?
      },
    ]
  end

  def slug_already_exists?
    unless published_at.nil?
      Post.where(published_at: published_at.all_day, slug: slug).exists?
    end
  end

  private

    def clean_slug!(slug)
      blank     = ''
      separator = '-'
      if self.slug
        self.slug = slug.downcase
          .gsub(/\(|\)|\[|\]\.|'|"|“|”|‘|’/, blank)
          .gsub(/&amp;/,         blank)
          .gsub(/\W|_|\s|-+/,    separator)
          .gsub(/^-+/,           blank)
          .gsub(/-+$/,           blank)
          .gsub(/-+/,            separator)
      end
    end

    def generate_slug
      candidate_index = 0
      self.slug = slug_candidates[candidate_index].call(self) if slug.blank?
      clean_slug!(slug)

      while slug.nil? || slug_already_exists?
        candidate_index += 1
        if candidate_index == slug_candidates.length
          self.slug = "#{slug} #{SecureRandom.hex(4)}"
        else
          self.slug = slug_candidates[candidate_index].call(self)
        end

        clean_slug!(slug)
      end
    end
end
