import { ApolloClient } from 'apollo-client'
import { createHttpLink } from 'apollo-link-http'
import { InMemoryCache } from 'apollo-cache-inmemory'

import { Meteor } from 'meteor/meteor'

export const client = new ApolloClient({
	link: createHttpLink({ uri: Meteor.absoluteUrl('graphql', { secure: Meteor.isProduction }) }),
	cache: new InMemoryCache(),
})

