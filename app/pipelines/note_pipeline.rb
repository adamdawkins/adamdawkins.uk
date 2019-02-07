require 'html/pipeline'
require_relative '../filters/line_break_filter'
context = {
  base_url: "https://twitter.com",
  username_pattern: /[a-z0-9][a-z0-9_]*/,
  tag_url: 'https://twitter.com/hashtag/%{tag}'
}


NotePipeline = HTML::Pipeline.new [
  HTML::Pipeline::MentionFilter,
  HTML::Pipeline::AutolinkFilter,
  HTML::Pipeline::HashtagFilter,
  HTML::Pipeline::LineBreakFilter
], context
