class AddIndieMarkTasks < ActiveRecord::Migration[5.2]
  def up
    level_1 = IndieMarkLevel.create(
      name: 'Level 1',
      description: 'IndieMark Level 1 has the general theme of owning your own domain, for sign-in, and publishing posts'
    )

    [
      ['#ownyouridentity', 'Personal domain that you use as your primary identity on the web.', 0.2, 1.day.ago],
      ['#useyouridentity', 'Setup Web sign-in for login, create user page on indieweb.org', 0.2, 1.day.ago],
      ['#ownyourdata - two permalinks', 'Post some kind of original cont on your own site', 0.2, 1.day.ago],
      ['#ownyourdata - h-entry markup', 'h-entry mark up of posts', 0.2, 1.day.ago],
      ['search', 'Allow robots to index, post content in HTML and site-specific searchability', 0.2]
    ].map do |title, details, score, completed_at|
      IndieMarkItem.create(title: title,
                           details: details,
                           score: score,
                           completed_at: completed_at,
                           indie_mark_level: level_1)
    end

    level_2 = IndieMarkLevel.create(
      name: 'Level 2',
      description: 'IndieMark Level 2 has the general theme of improving your personal identity, and posting multiple types of posts on your own site, one of which should be notes posted to your own site instead of Twitter (and POSSEing to Twitter if you have an account there).')

    [
      ['h-card contact info and icon of yourself on home page, suitable for others to add to their mobile device home screen.', 'name, url, and photo at a minimum. More info would be great. Ok to use a separate about page for more info as well.', 0.1],
      ['multiple post types required', 'I.e. Implement any two or more of: notes,  articles, replies, bookmarks, rsvp, checkins, photos, videos, audio, event, comics', 0.2],
      ['POSSE support multiple post types to applicable silos', 'POSSE support multiple post types to applicable silos that you list as "other profiles" as part of authentication, with either proper "u-url u-uid" links back to originals, and/or proper POSSE permashortlinks/permashortcitations back to originals, to enable original-post-discovery.', 0.1],
      ['POSSE-only type', 'e.g. all your tweets (posts to Twitter) are always just POSSE copies of posts from your site, then you get 0.1 points for each post type that you POSSE from your site to tweets up to the max total POSSE points.', 0.1],
      ['UI to cause POSSEing OR minimal configuration for auto-POSSE', 'minimal UI to cause POSSEing to happen if you POSSE semi-automatically (i.e. automatically compose POSSE content, post to silo via their API, or at least bring up a form where all you have to is click one button/link to complete the POSSE). OR minimal POSSE configuration/meta-info for POSSEing automatically (per-post, or default for all posts)', 0.1],
      ['Simple navigation', 'simple linear previous/next navigation between posts', 0.1],
      ['Simple search UI', 'Search UI and results for your content using an external search provider UI (e.g. Google) to provide time ordered results', 0.1],
      ['aggregation / syndication', 'autolinking of URLs, @-names, simple embeds of external resources (images, link previews), e.g. in notes posts', 0.1],
      ['Web Actions', 'one or more hard-coded actions for your most used silo (e.g. Tweet actions) if any, with <indie-action> element wrappers for all actions in your UI - so others can override them with their browsers to reply/favorite/repost to your posts on their own site.', 0.1]
    ].map do |title, details, score, completed_at|
      IndieMarkItem.create(title: title,
                           details: details,
                           score: score,
                           completed_at: completed_at,
                           indie_mark_level: level_2)
    end
  end

  def down
    level_1 = IndieMarkLevel.find_by(slug: 'level-1')
    level_1.destroy if level_1.present?
    level_2 = IndieMarkLevel.find_by(slug: 'level-2')
    level_2.destroy if level_2.present?
  end
end
