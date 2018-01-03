import React from 'react'
import { graphql } from 'react-apollo'
import { compose, flattenProp, mapProps } from 'recompose'

import { withLoading } from '../../helpers'
import allNotesQuery from './allNotes.graphql'

import Note from '../../components/Note'
import Author from '../../components/Author'

const Notes = ({ notes }) => (
	<div className="h-feed">
		<h3 className="p-name">Adam Dawkins' notes</h3>
		{notes.map(note => (<Note key={note.id} note={note} showAuthor={false} />))}
		<Author />
		<p><a className="u-url" href="/notes">Permalink</a></p>
	</div>
)

const data = graphql(allNotesQuery)

export default compose(
	data,
	withLoading,
	flattenProp('data'),
)(Notes)
