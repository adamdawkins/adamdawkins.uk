import React from 'react'
import { hydrate } from 'react-dom'

import '../imports/startup/client'
import Home from '../imports/ui/pages/Home/Home'

hydrate(
	<Home />,
	document.getElementById('root'),
)
