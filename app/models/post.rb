require "securerandom"

class SlugValidator < ActiveModel::Validator
  def validate(record)
    if record.new_record? && record.slug_already_exists?
      record.errors[:slug] << 'needs to be unique on the published date'
    end
  end
end

class Post < ApplicationRecord
  validates_presence_of :content
  validates_with SlugValidator

  has_many :syndicates, dependent: :destroy
  # has_many :webmentions, dependent: :destroy
  has_many :mentions, dependent: :destroy

  before_validation :generate_slug
  # after_save :create_webmentions
  before_destroy :delete_post_from_silos


  scope :published, -> { where("published_at IS NOT NULL").order("published_at DESC") }

  def published?
    published_at.present?
  end

  def publish
    self.published_at = Time.now
  end

  def publish!
    publish
    save
  end

  def params
    { year: published_at.year, month: published_at.month, day: published_at.day, slug: slug }
  end

  def slug_candidates
    [ ->(post) { post.slug },
      ->(post) { post.title },
      ->(post) { post.content[0, 150] if post.content.present?  },
      ->(post) { "#{SecureRandom.hex(4)} #{post.content}"[0, 150] }
    ]
  end

  def slug_already_exists?
    unless published_at.nil?
      existing_post = Post.where(published_at: published_at.all_day, slug: slug).first
      existing_post.present? && existing_post.id != id
    end
  end

  def links
    URI.extract(content)
  end

  def full_url
    Rails.application.routes.url_helpers.long_post_url(params)
  end

  private

    def clean_slug!
      return if slug.nil?
      blank     = ''
      separator = '-'
      self.slug = slug.downcase
        .gsub(/\(|\)|\[|\]\.|'|"|“|”|‘|’/, blank)
        .gsub(/&amp;/,         blank)
        .gsub(/\W|_|\s|-+/,    separator)
        .gsub(/^-+/,           blank)
        .gsub(/-+$/,           blank)
        .gsub(/-+/,            separator)
    end

    def generate_slug
      candidate_index = 0
      while slug.nil? || slug_already_exists?
        self.slug = slug_candidates[candidate_index].call(self)

        candidate_index += 1 if candidate_index < slug_candidates.length - 1
        clean_slug!
      end
      clean_slug!
    end

    def delete_post_from_silos
      "Delete post [#{id}]: Checking for syndicates to delete..."
      syndicates.each { |s| s.delete_post_from_silo }
    end

    def create_webmentions
      links.each do |link|
        Webmention.where(post_id: id, target: link).first_or_initialize.tap do |wm|
          wm.save
        end
      end
    end
end
