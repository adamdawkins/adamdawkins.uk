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
import ActivityFacepile from '../../partials/Notes/ActivityFacepile'
import ActivitySummary from '../../components/ActivitySummary'

const ShowNote = ({ note }) => (
	<div>
		<article className="h-entry">
			{<Author />}
			<NoteContent note={note} />
			{note.photo && (<img src={note.photo} alt="{note.content}" />)}
			<footer>
				<PublishedAt date={note.publishedAt} url={note.url} />
				<SyndicationLinks note={note} />
				<ActivitySummary activities={note._activityMeta} />
				<div style={{ display: 'flex', flexDirection: 'column' }}>
					<ActivityFacepile type="like" activities={note.likes} />
					<ActivityFacepile type="repost" activities={note.reposts} />
				</div>
				{ note.categories && (
					<div>
						Posted in {note.categories.map(cat => (<a key={cat} href={`/notes/categories/${cat}`} style={{ marginRight: '.5em' }}>{cat}</a>))}
					</div>
				)}
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
