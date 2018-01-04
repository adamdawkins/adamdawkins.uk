import marked from 'marked'
import moment from 'moment'
import { Meteor } from 'meteor/meteor'

import Notes from './notes'
import WebMentions from '../webmentions/webmentions'
import { propertyFieldsByType } from '../activities/resolvers'
import { merge } from '../../utils'

const notesQuery = () => Notes.find().fetch()
const noteQuery = (root, { id }) => Notes.findOne(id)

const createNoteMutation = (root, { note }) => {
	// TODO: authenticate this somehow, who says you're allowed to call this?
	const publishedAt = note.publishedAt ? moment(note.publishedAt).toDate() : new Date()
	const noteId = Notes.insert(merge(note, { publishedAt }))

	return Notes.findOne(noteId)
}

const Note = {
	id({ _id }) {
		return _id
	},
	content({ content }, { format = 'html' }) {
		return format === 'html' ? marked(content) : content
	},
	publishedAt({ publishedAt }) {
		return moment(publishedAt, moment.ISO_8601).format()
	},
	categories({ category }) {
		return category
	},
	url({ _id }) {
		return Meteor.absoluteUrl(`notes/${_id}`)
	},
	_micropub(note) {
		return {
			syndicateTo: note['mp-syndicate-to'],
		}
	},
	/* TODO: this query is identical to the activities query in `activities/resolvers`,
	 * and contains a fair bit of bespoke understanding of the format of the Webmentions collection.
	 * We should refactor into one place.
	 * Perhaps a `Repo` of sorts sitting next to the Mongo collection?
	 */
	activities({ _id }, { type }) {
		const query = {
			target: `https://adamdawkins.uk/notes/${_id}`,
		}
		if (type) {
			query['post.wm-property'] = propertyFieldsByType[type]
		}

		return WebMentions.find(query).fetch()
	},
	_activityMeta({ _id }) {
		const target = `https://adamdawkins.uk/notes/${_id}`
		// TODO: tie this to the schema somehow
		const types = [
			'repost',
			'like',
			'reply',
		]
		return types.map(type => ({
			type,
			count: WebMentions.find({ target, 'post.wm-property': propertyFieldsByType[type] }, { fields: { _id: 1 } }).count(),
		}))
	},
}

export {
	noteQuery,
	notesQuery,
	createNoteMutation,
	Note,
}
