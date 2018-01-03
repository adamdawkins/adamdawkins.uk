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
import NoteActivities from '../../partials/NoteActivities/NoteActivities'

const ShowNote = ({ note }) => (
	<div>
		<article className="h-entry">
			{<Author />}
			<NoteContent note={note} />
			<footer>
				<PublishedAt date={note.publishedAt} url={note.url} />
				<SyndicationLinks note={note} />
			</footer>
			<NoteActivities note={note} />
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
