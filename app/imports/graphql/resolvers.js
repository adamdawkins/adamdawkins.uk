import { noteQuery, notesQuery, createNoteMutation, Note } from '../api/notes/resolvers'
import { Activity, activitiesQuery } from '../api/activities/resolvers'

const Query = {
	note: noteQuery,
	notes: notesQuery,
	activities: activitiesQuery,
}

const Mutation = {
	createNote: createNoteMutation,
}

export default {
	Query,
	Mutation,

	Activity,
	Note,
}
