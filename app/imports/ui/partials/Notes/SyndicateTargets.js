import React from 'react'
import { branch, renderNothing, mapProps, compose } from 'recompose'

const SyndicateTargets = ({ targets }) => (
	<div>
		{targets.map(target => <a key={target} href={target} />)}
	</div>
)

const hideWithoutTargets = branch(
	({ note: { syndicateTargets } }) => !syndicateTargets.length,
	renderNothing,
)

export default compose(
	hideWithoutTargets,
	mapProps(({ note: { syndicateTargets: targets } }) => ({ targets })),
)(SyndicateTargets)
