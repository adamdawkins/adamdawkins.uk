import React from 'react'
import { graphql } from 'react-apollo'
import { compose, flattenProp, pure } from 'recompose'

import { withLoading } from '../../helpers'
import allNotesQuery from './allNotes.graphql'

import NoteListItem from '../../components/NoteListItem'
import Author from '../../components/Author'

const Notes = ({ notes }) => (
	<div className="h-feed">
		<h3 className="p-name">Adam's notes</h3>
		{notes.map(note => (<NoteListItem key={note.id} note={note} showAuthor={false} />))}
		<Author />
		<p><a className="u-url" href="/notes">Permalink</a></p>
	</div>
)

const data = graphql(allNotesQuery)

export default compose(
	data,
	withLoading,
	flattenProp('data'),
	pure,
)(Notes)
