require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to validate_presence_of :content }

  describe "sequence" do
    context "when the post has been published" do
      before do 
        subject.contents = "hello"
        subject.published_at = Time.now
      end

      context "no other posts have been published this day" do
        before do
          allow(Post).to receive_message_chain(:where, :count).and_return(0)
          subject.save
        end

        it "sets the sequence to 1" do
          expect(subject.sequence).to eq 1
        end

      end
      context "two other posts have been published on the same day" do
        before do
          allow(Post).to receive_message_chain(:where, :count).and_return(2)
          subject.save
        end
        it "sets the sequence to 3" do
          expect(subject.sequence).to eq 3
        end
      end
    end
  end
end
