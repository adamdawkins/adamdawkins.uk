class FixHexSlugs < ActiveRecord::Migration[5.2]
  def up
    starting_hex = /^[a-f0-9]{8}-/
    posts_with_bad_slugs = Post.all.select {|p| p.slug.match(starting_hex) }
    posts_with_bad_slugs.map do |post|
      post.slug = nil
      post.save
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
