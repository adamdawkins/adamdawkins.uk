import React from 'react'
import { ApolloProvider } from 'react-apollo'
import { BrowserRouter as Router } from 'react-router-dom'
import Routes from '../startup/routes'

import { client } from '../apollo/client'

const Root = () => (
	<ApolloProvider client={client}>
    <Router>
      <Routes />
    </Router>
	</ApolloProvider>
)

export default Root
