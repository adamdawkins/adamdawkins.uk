import React from 'react'
import { graphql } from 'react-apollo'
import { compose, flattenProp, mapProps } from 'recompose'

import { withLoading } from '../../helpers'
import allNotesQuery from './allNotes.graphql'

import Note from '../../components/Note'

const Notes = ({ notes }) => (
	<div>
		<h3>Notes</h3>
		{notes.map(note => (<Note key={note.id} note={note} />))}
	</div>
)

const data = graphql(allNotesQuery)

export default compose(
	data,
	withLoading,
	flattenProp('data'),
)(Notes)
