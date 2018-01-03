import React from 'react'
import { compose } from 'recompose'

const Home = () => (
	<div className="h-card">
		<h1><a className="p-name u-url" href="https://adamdawkins.uk">Adam Dawkins</a></h1>
		<p className="p-note">Web Developer at <a className="org url fn" href="http://www.dragondrop.uk">Dragon Drop</a>. Thoughts on <a href="https://medium.com/@adamdawkins" data-external="true">other things too</a>.</p>
		<p>Email me at <a className="u-email" href="mailto:adam@dragondrop.uk" rel="me">adam@dragondrop.uk</a></p>
	</div>
)

export default compose(
)(Home)
