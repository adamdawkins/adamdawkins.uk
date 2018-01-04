import { Meteor } from 'meteor/meteor'
import { HTTP } from 'meteor/http'

import createNoteMutation from './createNote.graphql'
import { runQuery } from '../../graphql'

// get's note from the JSON Body of a micropub request
const getNoteFromJSONBody = ({ properties: props }) => {
	const note = {}
	const keys = Object.keys(props)
	keys.forEach((key) => {
		if (key === 'category') {
			note.categories = props[key]
		} else {
			note[key] = props[key][0]
		}
	})

	return note
}

const indieAuthToken = async (Authorization) => {
	const { statusCode, data } = await HTTP.get('https://tokens.indieauth.com/token', {
		headers: {
			Accept: 'application/json',
			Authorization,
		},
	})
	if (statusCode !== 200) {
		throw new Meteor.Error(statusCode, 'Something wrong with IndieAuth')
	}

	return data
}

const authenticate = async (req, res) => {
	try {
		const tokenInfo = await indieAuthToken(req.headers.authorization)

		// TODO: more authentication to include client_id?
		if (tokenInfo.issued_by !== 'https://tokens.indieauth.com/token') {
			res.writeHead(403)
			return res.send('Forbidden')
		}
	} catch (err) {
		res.statusCode = 401
		return res.send('Something went wrong')
	}
	return true
}

const createNote = async note => runQuery(createNoteMutation, { note })

const micropubPost = async (req, res, next) => {
	if (req.method !== 'POST') {
		return next()
	}

	await authenticate(req, res, next)
	let note
	if (req.headers['content-type'] === 'application/json') {
		note = getNoteFromJSONBody(req.body)
	} else {
		const { content, category, photo } = req.body
		note = { content }
		if (category) {
			note.categories = category
		}
		if (photo) {
			note.photo = photo
		}
	}

	const { data: { note: { url } } } = await createNote(note)
	res.statusCode = 201
	res.setHeader('Location', url)
	return res.send()
}

export default micropubPost
