import React from 'react'
import { render } from 'react-dom'

import '../imports/startup/client'
import Root from '../imports/ui/Root'
import '../imports/ui/styles/main.scss'

render(
	<Root />,
	document.getElementById('root'),
)
