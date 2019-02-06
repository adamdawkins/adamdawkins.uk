class LinkPreviewService
  attr_reader :html
  def initialize(html)
    @html = html
  end

  def link_to_preview
    # THIS SHOULD BE SEPERATE TO THE GENERATION OF A LINK PREVIEW
    # The rules for deciding if there's a link to preview:
    # Currently just following Twitter's rule:
    # 1. If the link is the last thing in the post.
    # Future:
    # 2. If there's only one link in the note (and it's not a mention)
    # 3. If the link is the first thing in the note (that isn't a mention?)
    # 4. Links in articles could be different?
  end
end
