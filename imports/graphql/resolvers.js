import { noteQuery, notesQuery, Note } from '../api/notes/resolvers'
import { Activity, activitiesQuery } from '../api/activities/resolvers'

const Query = {
	note: noteQuery,
	notes: notesQuery,
	activities: activitiesQuery,
}

export default {
	Query,

	Activity,
	Note,
}
