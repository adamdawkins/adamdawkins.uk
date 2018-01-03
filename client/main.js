import React from 'react'
import { hydrate, render } from 'react-dom'

import '../imports/startup/client'
import Root from '../imports/ui/Root'

hydrate(
	<Root />,
	document.getElementById('root'),
)
