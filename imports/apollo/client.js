import { ApolloClient } from 'apollo-client'
import { createHttpLink } from 'apollo-link-http'
import { InMemoryCache } from 'apollo-cache-inmemory'

import { Meteor } from 'meteor/meteor'

const apolloClient = (req) => {
	const linkOptions = {
		uri: Meteor.absoluteUrl('graphql', { secure: Meteor.isProduction }),
	}

	let cache = new InMemoryCache()

	if (req && Meteor.isServer) {
		linkOptions.credentials = 'same-origin'
		linkOptions.headers = {
			cookie: req.header('Cookie'),
		}
	} else {
		cache = cache.restore(window.__APOLLO_STATE__)
	}

	return new ApolloClient({
		ssrMode: Meteor.isServer,
		link: createHttpLink(linkOptions),
		cache,
	})
}


export default apolloClient
