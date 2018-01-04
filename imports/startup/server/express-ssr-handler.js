import Express from 'express'
import bodyParser from 'body-parser'
import React from 'react'
import 'isomorphic-fetch'
import { StaticRouter } from 'react-router'
import { ApolloProvider, renderToStringWithData } from 'react-apollo'
import Helmet from 'react-helmet'

import { Meteor } from 'meteor/meteor'
import { WebApp } from 'meteor/webapp'

import apolloClient from '../../apollo/client'
import Routes from '../routes'

import { postWebMention } from '../../api/webmentions/server/routes'
import micropub from '../../api/micropub/endpoint'


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

	renderToStringWithData(App)
		.then((content) => {
			if (context.url) {
				// Somewhere a `<Redirect>` was rendered
				res.redirect(301, context.url)
				next()
			} else {
				const initialState = client.extract()
				const hydrateApollo = `<script>window.__APOLLO_STATE__=${JSON.stringify(initialState).replace(/</g, '\\u003c')};</script>`
				const helmet = Helmet.renderStatic()
				req.dynamicHead = `
					${helmet.title.toString()}
					${helmet.meta.toString()}
					${helmet.link.toString()}
					${helmet.style.toString()}
				`
				req.dynamicBody = `<div id="root">${content}</div> ${hydrateApollo}`

				next()
			}
		})
})
WebApp.connectHandlers.use(Meteor.bindEnvironment(app))
WebApp.connectHandlers.use(bodyParser.json())
WebApp.connectHandlers.use(bodyParser.urlencoded({ extended: false }))
WebApp.connectHandlers.use('/webmentions', Meteor.bindEnvironment(postWebMention))
WebApp.connectHandlers.use('/micropub', Meteor.bindEnvironment(micropub))
