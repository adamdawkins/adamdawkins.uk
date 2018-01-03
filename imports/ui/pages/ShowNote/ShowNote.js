import React from 'react'
import { graphql } from 'react-apollo'
import { compose, flattenProp } from 'recompose'

import { withLoading } from '../../helpers'
import query from './note.graphql'

import Note from '../../components/Note'

const ShowNote = ({ note }) => (
	<div>
		<Note note={note} />
	</div>
)

const data = graphql(query, {
	options: ({ match: { params: { id } } }) => ({ variables: { id } }),
})

export default compose(
	data,
	withLoading,
	flattenProp('data'),
)(ShowNote)
