import React from 'react'
import Express from 'express'
import 'isomorphic-fetch'
import { StaticRouter } from 'react-router'
import ReactDOM from 'react-dom/server'
import { ApolloProvider, renderToStringWithData } from 'react-apollo'

import { Meteor } from 'meteor/meteor'
import { WebApp } from 'meteor/webapp'

import apolloClient from '../../apollo/client'
import Routes from '../routes'

function Body({ content, state }) {
	console.log({content, state})
	return (
		<body>
			<div id="content" dangerouslySetInnerHTML={{ __html: content }} />
			<script dangerouslySetInnerHTML={{
				__html: `window.__APOLLO_STATE__=${JSON.stringify(state).replace(/</g, '\\u003c')};`,
			}} />
		</body>
	);
}

const app = Express()
app.use((req, res, next) => {
	const client = apolloClient(req)
	const context = {}
	const App = (
		<ApolloProvider client={client}>
			<StaticRouter context={context} location={req.url}>
				<Routes />
			</StaticRouter>
		</ApolloProvider>
	)
	renderToStringWithData(
		App
	).then((content) => {
		if (context.url) {
			// Somewhere a `<Redirect>` was rendered
			res.redirect(301, context.url)
			next()

		} else {

			const initialState = client.extract()
			const hydrateApollo = `<script>window.__APOLLO_STATE__=${JSON.stringify(initialState).replace(/</g, '\\u003c')};</script>`
			req.dynamicBody = `<div id="root" style="background: yellow">${content}</div> ${hydrateApollo}`

			next()
		}
	})

})
WebApp.connectHandlers.use(Meteor.bindEnvironment(app))
