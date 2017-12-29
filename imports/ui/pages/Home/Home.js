import React from 'react'
import { compose } from 'recompose'

import { logProps } from '../../helpers'

const Home = () => (
	<div>
		<h2>A new app has begun.</h2>
		<p>Check out README.md for the deetz</p>
	</div>
)

export default compose(
	logProps('Home', false),
)(Home)
