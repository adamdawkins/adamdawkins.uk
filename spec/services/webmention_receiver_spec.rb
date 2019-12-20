# require "rails_helper"
#
# RSpec.describe WebmentionReceiver do
#     context "receiver does not provide a status URL" do
#       it "*must* reply with an HTTP 202 Accepted response"
#       # it "*may* contain human-readable content"
#     end
#     describe "Webmention Verification" do
#       let(:source) { "http://webmentionfake.com/posts/adam" }
#       let(:target) { "http://adamdawkins.uk/posts/1" }
#       before :each do
#         stub_request(:get, source)
#       end
#       # it "*should* be handled asynchronously to prevent DoS attacks"
#       # ^^ We'll do this by calling the service from a job, no need to build it in.
#       it "*must* perform an HTTP GET request on the source" do
#         WebmentionReceiver.new(source, target)
#         expect(a_request(:get, source)).to have_been_made.once
#       end
#       it "*must* follow any redirects"
#       # it "*should* limit the number of redirects it follows"
#       # describe "it *must* confirm the source actually mentions the target" do
#       #   it "returns a 202 if the source mentinos the target" do
#       # end
#       # end
#       # describe "per-media-type rules to determine whether the source document mentions the target URL" do
#       #   it "looks for <a>, <img> and <video> in HTML documents"
#       #   it "looks for values matching the URL in JSON documents"
#       #   it "looks for the URL in plain text documents"
#       # end
#       # it "*must* have an exact match of the target URL provided to be considered valid"
#   #
#   #   describe "valid Webmention"  do
#   #     # it "*may* publish content from the source page on the target page"
#   #   end
#   #
#     context "target URL not found" do
#       before do
#         stub_request(:get, target).to_return(status: 404)
#       end
#
#       it "returns a 400 Bad Request" do
#
#       end
#     end
#
#     context "the sender did something wrong" do
#       it "*must* send a 400 Bad Request status code"
#       # it "*may* include a description of the error in the response body"
#
#       describe "errors before fetching" do
#         it "errors if specified target URL not found" do
#         end
#         it "errors if specified target URL does not accept Webmentions"
#         it "errors if source was malformed or is not a supported URL scheme (e.g. a mailto: link)"
#       end
#
#       describe "errors after fetching" do
#         it "errors if source URL not found"
#         it "errors if source URL does not contain a link to the target URL"
#       end
#     end
#
#     context "An error on the receiver's end" do
#       it "*should* return a 500 Internal Server Error"
#       it "*may* include a description of the error in the response body"
#     end
#   end
#   #
#   #   describe "updating existing Webmentions" do
#   #     it "*should* update any existing data it picked from *source* for the existing Webmention"
#   #     context "when it supports updating Webmetions" do
#   #       it "*must* support updating data from properties of the primary object of a source (e.g. h-entry props)"
#   #       it "*may* support updating child-data"
#   #     end
#   #
#   #     context "410 Gone received" do
#   #       it "*should* delete the existing Webmention, or mark it as deleted"
#   #     end
#   #
#   #     context "target URL no longer found on source" do
#   #       it "*should* delete the existing Webmention, or mark it as deleted"
#   #     end
#   #
#   #     it "*should* be idempotent, mulitple Webmentions with no content changes should not be shown as multiple replies"
#   #
#   #   end
# end
