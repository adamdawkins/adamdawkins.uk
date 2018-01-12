import React from 'react'
import { compose } from 'recompose'
import AdamCard from '../../partials/AdamCard'

const Home = () => (
	<div className="c">
		<div className="row">
			<h1>Adam Dawkins</h1>
		</div>
		<div className="row">
			<div className="col 6">
				<AdamCard />
			</div>
		</div>
	</div>
)

export default compose()(Home)
