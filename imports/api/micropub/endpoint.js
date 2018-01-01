import { Meteor } from 'meteor/meteor'
import { HTTP } from 'meteor/http'

const indieAuthToken = async (bearer) => {
	const { statusCode, data } = await HTTP.get('https://tokens.indieauth.com/token', {
		headers: {
			Accept: 'application/json',
			Authorization: bearer,
		},
	})

	if (statusCode !== 200) {
		throw new Meteor.Error(statusCode, 'Error from IndieAuth')
	}

	return data
}

const micropub = (req, res) => {
	let body = ''
	req.on('data', Meteor.bindEnvironment((data) => {
		body += data
	}));

	req.on('end', Meteor.bindEnvironment(async () => {
		const { headers, method } = req

		const tokenInfo = await indieAuthToken(headers.authorization)
		console.log({ tokenInfo })

		res.writeHead(200);
	}));
}

export default micropub
