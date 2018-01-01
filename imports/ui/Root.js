import React from 'react'
import { ApolloProvider } from 'react-apollo'
import {
	BrowserRouter as Router,
	Route,
} from 'react-router-dom'

import { client } from '../apollo/client'

import Home from './pages/Home/Home'

const Root = () => (
	<ApolloProvider client={client}>
		<div>
			<main>
				<Router>
					<Route exact path="/" component={Home} />
				</Router>
			</main>
		</div>
	</ApolloProvider>
)

export default Root
