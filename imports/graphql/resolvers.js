import { noteQuery, notesQuery, Note } from '../api/notes/resolvers'
import { Activity } from '../api/activities/resolvers'

const Query = {
	note: noteQuery,
	notes: notesQuery,
}

export default {
	Query,

	Activity,
	Note,
}
