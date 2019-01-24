require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  # tests copied from https://github.com/kylewm/cassis-autolink-py/blob/master/cassistest.py
  describe "auto_link" do
    context "Twitter usernames" do
      it "adds links to @usernames" do
        expect(helper.auto_link("@adamdawkins")).to eq '<a class="auto-link h-x-username" href="https://twitter.com/adamdawkins">@adamdawkins</a>'
      end
      it "preserves whitespace around username" do
        expect(helper.auto_link(" @adamdawkins ")).to eq ' <a class="auto-link h-x-username" href="https://twitter.com/adamdawkins">@adamdawkins</a> '
      end
      it "links next to another word" do
        expect(helper.auto_link("hi @adamdawkins")).to eq 'hi <a class="auto-link h-x-username" href="https://twitter.com/adamdawkins">@adamdawkins</a>'
      end

      it "skips no name" do
        expect(helper.auto_link("@")).to eq '@'
      end
    end

    context "URL" do
      it "turns named links into URLs" do
        expect(helper.auto_link("dragondrop.uk")).to eq '<a class="auto-link" href="http://dragondrop.uk">dragondrop.uk</a>'
      end

      it "strips protocol from displayed text" do
        expect(helper.auto_link("https://dragondrop.uk")).to eq '<a class="auto-link" href="https://dragondrop.uk">dragondrop.uk</a>'
      end
    end
    context "gif" do
      it "turns the link into an image" do
        expect(helper.auto_link("https://media.giphy.com/media/giphy.gif")).to eq '<a class="auto-link" href="https://media.giphy.com/media/giphy.gif"><img src="https://media.giphy.com/media/giphy.gif" /></a>'
      end
    end
    context "hashtag" do
      it "turns the hashtag into a link" do
        expect(helper.auto_link("#slacklogo")).to eq '<a class="auto-link" href="https://twitter.com/hashtag/slacklogo">#slacklogo</a>'
      end
      it "doesn't go over word boundaries" do
        expect(helper.auto_link(" #slack logo")).to eq ' <a class="auto-link" href="https://twitter.com/hashtag/slack">#slack</a> logo'
      end
      it "ignores hashtags that are part of other words or URLs" do
        expect(helper.auto_link(".html#anchor")).to eq '.html#anchor'
      end
    end
  end
end
