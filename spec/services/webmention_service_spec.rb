require "rails_helper"

# This spec is written based on the criteria in the W3C recommendation:
# https://www.w3.org/TR/webmention/
# The https://webmention.rocks tests each test different parts of the implementation
# So we use those and trust they match the right parts of the spec
# Where a webmention.rocks test covers multiple test cases, I've put it in both.

RSpec.describe WebmentionService do
  describe "Sending Webmentions" do
    describe "endpoint discovery", :vcr do
      it "*must* fetch the link" do
        WebmentionService.new("https://webmention.rocks/test/1")
        expect(a_request(:get, "https://webmention.rocks/test/1")).to have_been_made
      end
      it "*must* follow all redirects"
      it "*must* check for a header rel value of 'webmention'" do
        expect(
          WebmentionService.new("https://webmention.rocks/test/2").endpoint
        ).to eq "https://webmention.rocks/test/2/webmention"
      end
      it "*must* check for a <link> with a rel value of 'webmention'" do
        # 3. has a relative URL
        # 4. has an absolute
        expect(
          WebmentionService.new("https://webmention.rocks/test/3").endpoint
        ).to eq "https://webmention.rocks/test/3/webmention"
        expect(
          WebmentionService.new("https://webmention.rocks/test/4").endpoint
        ).to eq "https://webmention.rocks/test/4/webmention"
      end
      it "*must* check for a <a> with a rel value of 'webmention'"
      it "*must* resolves relative endpoint URLs" do
        # 1. Uses Link header
        # 3. uses a <link> tag
        expect(
          WebmentionService.new("https://webmention.rocks/test/1").endpoint
        ).to eq "https://webmention.rocks/test/1/webmention"
        expect(
          WebmentionService.new("https://webmention.rocks/test/3").endpoint
        ).to eq "https://webmention.rocks/test/3/webmention"
      end
      it "*must* preserve query string parameters"
      # it "*may* make a HEAD request to check for Link header before making a GET request"
      # it "*may* customize the User Agent to include the string 'Webmention'"
      # it "*should* respect the HTTP cache headers"
    end

    # describe  "notifying receiver" do
    #   it "*must* post x-www-form-urlencoded source and target to endpoint"
    #   context "endpoint contains query string parameter" do
    #     it "*must* preserve query string parameters and not send them in the POST body"
    #   end
    #
    #   it "*must* consider any 2xx responses a success"
    #
    #   context "if localhost or 127.0.0.* endpoint detected" do
    #     # it "*should not* send the Webmention to that endpoint"
    #   end
    # end

    # describe "sending Webmentions for updated posts" do
    #   # it "*should* re-send any previously sent Webmentions"
    #   # it "*should* re-send Webmentions to any URLs that have been removed from the document"
    #   it "*must* re-discover the Webmention endpoint of each target URL"
    # end

    # describe "sending Webmentions for deleted posts" do
    #   # it "*should* set a 410 Gone sattus code for the URL"
    #   # it "*should* display a 'tombstone' represenation of the deleted post"
    #   # it "*should* re-send Webmentions for every previously sent Webmention for that document"
    # end
  end

  # describe "receiving" do
  #   it "*should* verify the parameters"
  #   context "receiver does not provide a status URL" do
  #     it "*must* reply with an HTTP 202 Accepted response"
  #     # it "*may* contain human-readable content"
  #   end
  #   describe "Webmention Verification" do
  #     it "*should* be handled asynchronously to prevent DoS attacks"
  #     it "*must* perform and HTTP GET request on the source"
  #     it "*must* follow any redirects"
  #     # it "*should* limit the number of redirects it follows"
  #     it "*must* confirm the source actual mentions the target"
  #     describe "per-media-type rules to determine whether the source document mentions the target URL" do
  #       it "looks for <a>, <img> and <video> in HTML documents"
  #       it "looks for values matching the URL in JSON documents"
  #       it "looks for the URL in plain text documents"
  #     end
  #     it "*must* have an exact match of the target URL provided to be considered valid"
  #   end
  #
  #   describe "valid Webmention"  do
  #     # it "*may* publish content from the source page on the target page"
  #   end
  #
  #   describe "Error Responses" do
  #     context "the sender did something wrong" do
  #       it "*must* send a 400 Bad Request status code"
  #       # it "*may* include a description of the error in the response body"
  #
  #       describe "errors before fetching" do
  #         it "errors if specified target URL not found"
  #         it "errors if specified target URL does not accept Webmentions"
  #         it "errors if source was malformed or is not a supported URL scheme (e.g. a mailto: link)"
  #       end
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
  #
  #   describe "updating existing Webmentions" do
  #     it "*should* update any existing data it picked from *source* for the existing Webmention"
  #     context "when it supports updating Webmetions" do
  #       it "*must* support updating data from properties of the primary object of a source (e.g. h-entry props)"
  #       it "*may* support updating child-data"
  #     end
  #
  #     context "410 Gone received" do
  #       it "*should* delete the existing Webmention, or mark it as deleted"
  #     end
  #
  #     context "target URL no longer found on source" do
  #       it "*should* delete the existing Webmention, or mark it as deleted"
  #     end
  #
  #     it "*should* be idempotent, mulitple Webmentions with no content changes should not be shown as multiple replies"
  #
  #   end
  # end
end
