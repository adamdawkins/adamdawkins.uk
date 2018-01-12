import React from 'react'
import propTypes from 'prop-types'
import { branch, renderNothing, mapProps, compose } from 'recompose'

const SyndicateTargets = ({ targets }) => (
	<div>
		{targets.map(target => <a key={target} href={target} style={{ display: 'none', speak: 'none' }}>{target}</a>)}
	</div>
)

const hideWithoutTargets = branch(
	({ note: { syndicateTargets } }) => !syndicateTargets.length,
	renderNothing,
)

SyndicateTargets.propTypes = {
	targets: propTypes.arrayOf(propTypes.string).isRequired,
}

export default compose(
	hideWithoutTargets,
	mapProps(({ note: { syndicateTargets: targets } }) => ({ targets })),
)(SyndicateTargets)
