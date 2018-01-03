import marked from 'marked'
import moment from 'moment'
import { Meteor } from 'meteor/meteor'

import Notes from '../../api/notes/notes'

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
}

export {
	noteQuery,
	notesQuery,
	Note,
}
