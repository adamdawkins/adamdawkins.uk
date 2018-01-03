import React from 'react'
import { renderNothing, branch, compose } from 'recompose'

import SyndicationLink from './SyndicationLink'

const SyndicationLinks = ({ note: { syndicates } }) => (
	<p>
		Also on {syndicates.map(link => (
			<span key={link.id}>
				<SyndicationLink name={link.id} url={link.url} />,
			</span>
		))}
	</p>
)
const hasNoSyndicates = ({ note }) => !note.syndicates

const hideIfNoSyndicates = branch(
	hasNoSyndicates,
	renderNothing,
)

export default compose(
	hideIfNoSyndicates,
)(SyndicationLinks)
