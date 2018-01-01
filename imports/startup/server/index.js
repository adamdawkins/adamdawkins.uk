// Import the stuff we need to load from the API (Methods, Collections, publications)
import '../../api'

// Seed DB
import './seeds'

// Setup Apollo Server
import './apollo_server'

import micropubEndpoint from '../../api/micropub/endpoint'
import { WebApp } from 'meteor/webapp'

WebApp.connectHandlers.use('/micropub', micropubEndpoint)
