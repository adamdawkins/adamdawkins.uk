import React from 'react'
import { graphql } from 'react-apollo'
import { compose, flattenProp } from 'recompose'

import {withLoading } from '../../helpers'
import query from './activities.graphql'

import Activity from '../../components/Activity'

const NoteActivities = ({ activities }) => (
	<div>
		{activities && activities.map(a => <Activity key={a.source} activity={a} />)}
	</div>
)

const data = graphql(query, {
	options: ({ note: { id } }) => ({
		variables: { id },
	}),
})

export default compose(
	data,
	withLoading,
	flattenProp('data')
)(NoteActivities)
