import { Engine } from 'apollo-engine'

import { createApolloServer } from 'meteor/apollo'
import { WebApp } from 'meteor/webapp'

import { schema } from '../../graphql/index'

const PORT = process.env.PORT || 3000;

// Initialize Apollo Engine
const engine = new Engine({
	engineConfig: {
		apiKey: 'service:adamdawkins-5245:myRT4xxSzvEYWkXC9UYRZg',
		logging: {
			level: 'DEBUG', // DEBUG, INFO, WARN or ERROR
		},
	},
	graphqlPort: PORT,
	endpoint: '/graphql',
})

engine.start()


createApolloServer({
	schema,
	tracing: true,
	cacheControl: true,
}, {
	configServer: ( app ) => {
		console.log('setting up apollo server to use engine')
		app.use(engine.connectMiddleware())
	},
})
