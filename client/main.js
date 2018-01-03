import React from 'react'
import { hydrate } from 'react-dom'

import '../imports/startup/client'
import Root from '../imports/ui/Root'
import '../imports/ui/styles/ad.css'

hydrate(
	<Root />,
	document.getElementById('root'),
)
