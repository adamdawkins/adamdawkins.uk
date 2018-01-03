import { noteQuery, notesQuery, Note } from '../api/notes/resolvers'

const Query = {
	note: noteQuery,
	notes: notesQuery,
}

export default {
	Query,
	Note,
}
