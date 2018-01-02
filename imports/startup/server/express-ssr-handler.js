import React from 'react'
import Express from 'express'
import { StaticRouter } from 'react-router'
import ReactDom from 'react-dom/server'

import { Meteor } from 'meteor/meteor'
import { WebApp } from 'meteor/webapp'

import Routes from '../routes'

const app = Express()
app.use((req, res, next) => {
	const App = (
		<StaticRouter context={{}} location={req.url}>
			<Routes />
		</StaticRouter>
	)

	const content = ReactDom.renderToString(App)
	req.dynamicBody = `<div id="root">${content}</div>`
	next()
})
WebApp.connectHandlers.use(Meteor.bindEnvironment(app))
