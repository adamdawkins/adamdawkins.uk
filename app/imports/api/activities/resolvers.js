import moment from 'moment'
import marked from 'marked'

import Notes from '../notes/notes'
import WebMentions from '../webmentions/webmentions'

// the name of the `post.wm-property` for each postType
export const propertyFieldsByType = {
	reply: 'in-reply-to',
	like: 'like-of',
	repost: 'repost-of',
}

export const activityTypesByPropertyField = {
	'in-reply-to': 'reply',
	'like-of': 'like',
	'repost-of': 'repost',
}

/* NB: At the moment we're not separating out activities into a collection,
 * we're storing Web Mentions just as they come from brid.gy via webmention.io.
 * It's the webmention collection we're playing with here.
*/

const activitiesQuery = (root, { noteId, type }) => {
	const query = {}
	if (noteId) {
		query.target = `https://adamdawkins.uk/notes/${noteId}`
	}

	if (type) {
		query['post.wm-property'] = propertyFieldsByType[type]
	}

	return WebMentions.find(query).fetch()
}

const Activity = {
	target({ target }) {
		const id = target.match(/\w*$/)[0]
		return Notes.findOne(id)
	},
	type({ post }) {
		return activityTypesByPropertyField[post['wm-property']]
	},
	publishedAt({ post: { published, 'wm-recieved': recieved } }) {
		// if we don't have a published date, use the web mention received date
		const date = published || recieved
		return moment(date, moment.ISO_8601).format()
	},
	url({ post: { url } }) {
		return url
	},
	content({ post: { content, 'wm-property': type } }, { format = 'html', repliesOnly = true }) {
		if (!repliesOnly || type === propertyFieldsByType.reply) {
			if (format !== 'html') {
				return content.text
			}
			if (content['content-type'] === 'text/html' && content.html) {
				return content.html
			}

			return marked(content.text)
		}

		return ''
	},
	author({ post: { author } }) {
		return author
	},
}

export {
	activitiesQuery,
	Activity,
}
