import React from 'react'
import { hydrate } from 'react-dom'

import '../imports/startup/client'
import Home from '../imports/ui/pages/Home/Home'
import '../imports/ui/styles/main.scss'

hydrate(
	<Home />,
	document.getElementById('root'),
)
