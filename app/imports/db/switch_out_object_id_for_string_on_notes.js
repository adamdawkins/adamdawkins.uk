import { Mongo } from 'meteor/mongo'

import Notes from '../imports/api/notes/notes'

const notes = Notes.find().fetch()

notes.forEach((note) => {
	const { _id } = note
	if (typeof _id === 'object') {
		const id = _id._str
		if (!Notes.findOne(id)) {
			Notes.insert(
				Object.assign(note, {_id: id })
			)
			Notes.remove({_id: Mongo.ObjectID(id)})
		}
	}
})
