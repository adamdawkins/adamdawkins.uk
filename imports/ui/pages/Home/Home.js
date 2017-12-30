import React from 'react'
import { compose } from 'recompose'

import { logProps } from '../../helpers'

const Home = () => (
	<div>
		<h2>On the web</h2>
		<ul>
			<li><a href="https://twitter.com/adamdawkins" rel="me">@adamdawkins on Twitter</a></li>
			<li><a href="https://github.com/adamdawkins" rel="me">Github</a></li>
		</ul>
	</div>
)

export default compose(
	logProps('Home', false),
)(Home)
