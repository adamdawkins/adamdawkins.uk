import { noteQuery, notesQuery, createNoteMutation, Note, updateNoteMutation } from '../api/notes/resolvers'
import { Activity, activitiesQuery } from '../api/activities/resolvers'

const Query = {
	note: noteQuery,
	notes: notesQuery,
	activities: activitiesQuery,
}

const Mutation = {
	createNote: createNoteMutation,
	updateNote: updateNoteMutation,
}

export default {
	Query,
	Mutation,

	Activity,
	Note,
}
