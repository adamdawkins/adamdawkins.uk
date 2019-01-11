require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validation" do
    it { is_expected.to validate_presence_of :content }
  
    # We're getting round this by actually looping through the stack of candidates
    # describe "slug validation" do
    #   before do 
    #     create(:post, published_at: 1.day.ago, slug: "the-same-slug")
    #   end
    #   it "requires slugs to be unique for posts on the same day" do
    #     new_post = Post.create(content: "content", published_at: 1.day.ago, slug: "the_same_slug")
    #
    #     expect(new_post.valid?).to eq false
    #   end
    # end
  end

  describe "slug" do
    context "when the Post has a slug" do
      it "uses the slug" do
        post = create(:post, title: "title", slug: "slug", content: "content")
        expect(post.slug).to eq "slug"
      end

      it "cleans provided slugs" do
        post = create(:post, slug: "this isn't going to work as a slug")
        expect(post.slug).to eq "this-isnt-going-to-work-as-a-slug"
      end
    end

    context "when the Post has a title" do
      it "generates the slug from the title" do
        post = create(:post, title: 'The Title')
        expect(post.slug).to eq 'the-title'
      end
    end

    context "when the Post doesn't have a title" do
      it "generates the slug from the content" do
        post = create(:post, title: nil, content: "This is the content")
        expect(post.slug).to eq 'this-is-the-content'
      end
       it "truncates long" do
         post = create(:post, content: Faker::Lorem.characters(500))

         expect(post.slug.length).to eq 150
       end
    end

    context "when the slug has changed" do
      it "updates the slug" do
        post = create(:post, slug: "slug")
        post.update(slug: "slug-2")

        expect(post.slug).to eq "slug-2"
      end

       it "cleans the slug" do
         post = create(:post, slug: "slug")
         post.update(slug: "slug 2")

         expect(post.slug).to eq "slug-2"
       end
    end

    context "when the slug hasn't changed, but other attributes have" do
      it "does not update the slug" do
        post = create(:post, slug: 'slug')
        post.update(title: "A new title", content: "Some new content")

        expect(post.slug).to eq "slug"
      end
    end
    
    context "when the slug isn't unique for the day" do
      it "tries the next candidate" do
        old_post = create(:post, slug: 'slug', published_at: 2.days.ago)
        post = create(:post, slug: 'slug', title: 'title', published_at: 2.days.ago)

        expect(post.slug).to eq 'title'
      end
    end
  end
end
