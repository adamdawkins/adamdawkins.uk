import React from 'react'
import { ApolloProvider } from 'react-apollo'
import { BrowserRouter as Router } from 'react-router-dom'
import Routes from '../startup/routes'

import apolloClient from '../apollo/client'

const Root = () => (
	<ApolloProvider client={apolloClient()}>
		<Router>
			<Routes />
		</Router>
	</ApolloProvider>
)

export default Root
