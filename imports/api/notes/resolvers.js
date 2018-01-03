import marked from 'marked'
import moment from 'moment'
import { Meteor } from 'meteor/meteor'

import Notes from './notes'
import WebMentions from '../webmentions/webmentions'

const notesQuery = () => Notes.find().fetch()
const noteQuery = (root, { id }) => Notes.findOne(id)

const Note = {
	id({ _id }) {
		return _id
	},
	content({ content }, { format = 'html' }) {
		return format === 'html' ? marked(content) : content
	},
	publishedAt({ created_at }) {
		return moment(created_at, moment.ISO_8601).format()
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
	activities({ _id }) {
		const mentions = WebMentions.find({ target: `https://adamdawkins.uk/notes/${_id}` }).fetch()
		console.log({mentions})
		return mentions
	},
	_activityMeta({ _id }) {
		const target = `https://adamdawkins.uk/notes/${_id}`
		// TODO: tie this to the schema somehow
		const types = [
			'repost',
			'like',
			'reply',
			'mention',
		]
		return types.map(type => ({
			type,
			count: WebMentions.find({ target, 'activity.type': type }, { fields: { _id: 1 } }).count(),
		}))
	},
}

export {
	noteQuery,
	notesQuery,
	Note,
}
