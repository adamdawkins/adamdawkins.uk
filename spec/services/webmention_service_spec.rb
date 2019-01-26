require "rails_helper"

# This spec is written based on the criteria in the W3C recommendation:
# https://www.w3.org/TR/webmention/
# The https://webmention.rocks tests each test different parts of the implementation
# So we use those and trust they match the right parts of the spec
# Where a webmention.rocks test covers multiple test cases, I've put it in both.

def webmention_rocks_endpoint_test(test_numbers = [])
  test_numbers.each do |number|
    expect(
      WebmentionService.new("https://webmention.rocks/test/#{number}").endpoint
    ).to eq "https://webmention.rocks/test/#{number}/webmention"
  end
end

RSpec.describe WebmentionService do
  describe "Sending Webmentions" do
    describe "endpoint discovery", :vcr do
      it "*must* fetch the link" do
        WebmentionService.new("https://webmention.rocks/test/1")
        expect(a_request(:get, "https://webmention.rocks/test/1")).to have_been_made
      end
      it "*must* follow all redirects"
      it "*must* check for a header rel value of 'webmention'" do
        # 2. is rel=webmention
        # 8. is rel="webmention"
        # 18. parses multiple Link headers, but only one with webmention
        # 19. provides one Link header, but with mulitple values
        webmention_rocks_endpoint_test([2, 8, 18, 19])
      end

      it "finds an HTTP Link header with multiple rel values" do
        webmention_rocks_endpoint_test([10])
      end

      it "*must* check for a <link> with a rel value of 'webmention'" do
        # 3. has a relative URL
        # 4. has an absolute
        webmention_rocks_endpoint_test([3, 4])
      end
      it "finds a <link> with multiple rel values" do
        # 9. <link rel="webmention somethingelse" />
        webmention_rocks_endpoint_test([9])
      end

      it "skips the <link> tag with no href" do
        # This post has a <link> tag which has no href attribute
        webmention_rocks_endpoint_test([20])
      end

      it "*must* check for a <a> with a rel value of 'webmention'" do
        # 5. has a relative URL
        # 6. has an absolute
        webmention_rocks_endpoint_test([5, 6])
      end

      it "*must* resolves relative endpoint URLs" do
        # 1. Uses Link header
        # 3. uses a <link> tag
        # 5. uses an <a> tag
        # 15. uses a <link> with an empty string, testing that the page itself is the endpoint
        webmention_rocks_endpoint_test([1, 3, 5])
        expect(
          WebmentionService.new("https://webmention.rocks/test/15").endpoint
        ).to eq "https://webmention.rocks/test/15"
      end

      it "selects endpoint in priority order: HTTP Link header then earliest element" do
        # 11. contains a Link header (should be chosen), a <link> and an <a>
        # 16. contains an <a> before a <link>, the <a> should be chosen
        # 17. contains a <link> before an <a>, the <link> should be chosen
        webmention_rocks_endpoint_test([11, 16, 17])
      end

      it "does not match the rel tag 'not-webmention'" do
        # 12. This post contains a link tag with a rel value of "not-webmention",
        #     just to make sure you aren't using naïve string matching to find the endpoint.
        webmention_rocks_endpoint_test([12])
      end

      it "ignores rel='webmention' links in HTML comments" do
        # 13. This post contains an HTML comment that contains a rel=webmention element,
        #     which should not receive a Webmention since it's inside an HTML comment.
        webmention_rocks_endpoint_test([13])
      end
       it "ignores escaped code with rel='webmention'" do
        # 14. This post contains sample code with escaped HTML which should not
        #     be discovered by the Webmention client.

        webmention_rocks_endpoint_test([14])
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
