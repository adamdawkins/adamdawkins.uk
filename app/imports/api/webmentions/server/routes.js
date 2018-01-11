import omit from 'lodash.omit'
import WebMentions from '../webmentions'

const postWebMention = (req, res, next) => {
	if (req.method !== 'POST') {
		return next()
	}
	if (req.body.secret !== process.env.WEBMENTION_IO_SECRET) {
		return res.status(403).send("Sorry, I don't know you")
	}

	const webMention = omit(req.body, 'secret')
	try {
	const id = WebMentions.insert(webMention)
	console.log(`Inserted WebMention with id ${id}`)
	return res.status(201).send('WebMention created')
	} catch (err) {
		console.error("Something went wrong creating a web mention, probably a dupe")
		console.error(err.stack)
		return res.status(500).send('')
	}
}

export {
	postWebMention,
}
