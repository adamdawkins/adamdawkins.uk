import { makeExecutableSchema } from 'graphql-tools'
import { graphql } from 'graphql'

import typeDefs from './schema.graphql'
import resolvers from './resolvers'

export const schema = makeExecutableSchema({ typeDefs, resolvers })

// A helper for running GraphQL queries from the server
export const runQuery = (input, variables) => {
	let graphqlQuery

	if (typeof input === 'string') {
		graphqlQuery = input
	} else {
		// for use with imported queries from .graphql files
		graphqlQuery = input.loc.source.body
	}
	return graphql(schema, graphqlQuery, null, null, variables)
}

