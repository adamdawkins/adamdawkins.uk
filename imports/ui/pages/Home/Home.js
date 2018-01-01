import React from 'react'
import { compose } from 'recompose'

import { logProps } from '../../helpers'

const Home = () => (
	<div>
		<p className="h-card">
			<a className="p-name u-url" href="https://adamdawkins.uk">Adam Dawkins</a>
		</p>
		<p>Web Developer at <a href="http://www.dragondrop.uk">Dragon Drop</a>. Thoughts on <a href="https://medium.com/@adamdawkins">other things too</a>.</p>
	</div>
)

export default compose(
	logProps('Home', false),
)(Home)
