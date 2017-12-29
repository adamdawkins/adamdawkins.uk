import { createApolloServer } from 'meteor/apollo'
import { schema } from '../../graphql/index'
const { log } = console

createApolloServer({ schema })
