import { noteQuery, notesQuery, createNoteMutation, Note, updateNoteMutation, deleteNoteMutation } from '../api/notes/resolvers'
import { Activity, activitiesQuery } from '../api/activities/resolvers'

const Query = {
	note: noteQuery,
	notes: notesQuery,
	activities: activitiesQuery,
}

const Mutation = {
	createNote: createNoteMutation,
	updateNote: updateNoteMutation,
	deleteNote: deleteNoteMutation,
}

export default {
	Query,
	Mutation,

	Activity,
	Note,
	Syndicate: {
		platform: ({ id, platform }) => platform ? platform : id
	},
}
