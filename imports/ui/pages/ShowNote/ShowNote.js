import React from 'react'
import { graphql } from 'react-apollo'
import { propType } from 'graphql-anywhere'
import { compose, flattenProp } from 'recompose'

import { withLoading } from '../../helpers'
import query from './note.graphql'

import NoteContent from '../../components/NoteContent'
import Author from '../../components/Author'
import SyndicationLinks from '../../components/SyndicationLinks'
import PublishedAt from '../../components/PublishedAt'

const ShowNote = ({ note }) => (
	<div>
		<article className="h-entry">
			{<Author />}
			<NoteContent note={note} />
			<footer>
				{note.publishedAt && <PublishedAt note={note} /> }
				<SyndicationLinks note={note} />
			</footer>
		</article>
	</div>
)

ShowNote.propTypes = {
	note: propType(query).isRequired,
}

const data = graphql(query, {
	options: ({ match: { params: { id } } }) => ({ variables: { id } }),
})

export default compose(
	data,
	withLoading,
	flattenProp('data'),
)(ShowNote)
