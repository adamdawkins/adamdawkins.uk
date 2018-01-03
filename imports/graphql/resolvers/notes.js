import marked from 'marked'
import moment from 'moment'
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
	createdAt({ created_at }) {
		return moment(created_at, moment.ISO_8601).format()
	},
	categories({ category }) {
		return category
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
