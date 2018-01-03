import { noteQuery, notesQuery, Note } from './resolvers/notes'

const Query = {
	note: noteQuery,
	notes: notesQuery,
}

export default {
	Query,
	Note,
}
