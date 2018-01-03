import moment from 'moment'
import marked from 'marked'

import Notes from '../notes/notes'

/* NB: At the moment we're not separating out activities into a collection,
 * we're storing Web Mentions just as they come from brid.gy via webmention.io.
 * It's the webmention collection we're playing with here.
*/

const Activity = {
	target({ target }) {
		const id = target.match(/\w*$/)[0]
		return Notes.findOne(id)
	},
	type({ activity: { type } }) {
		return type
	},
	publishedAt({ data: { published } }) {
		// Let's stay consistent
		return moment(published, moment.ISO_8601).format()
	},
	content({ data: { content }, activity: { type } }, { format = 'html', repliesOnly = true }) {
		if (!repliesOnly || type === 'reply') {
			return format === 'html' ? marked(content) : content
		}

		return ''
	},
	author({ data: { author } }) {
		return author
	},
}

export {
	Activity,
}
