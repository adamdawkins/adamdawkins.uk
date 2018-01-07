import { HTTP } from 'meteor/http'

// conforms to the format of POSTing a target and a source
const sendWebMention = async (endpoint, { target, source }) => (
	HTTP.post(endpoint, { params: { target, source } })
)

export default sendWebMention
