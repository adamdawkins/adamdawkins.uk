import React from 'react'
import propTypes from 'prop-types'
import { compose } from 'recompose'

import Author from './Author'
import SyndicationLinks from './SyndicationLinks'
import NoteContent from './NoteContent'
import PublishedAt from './PublishedAt'
import ActivitySummary from './ActivitySummary'

const NoteListItem = ({ note, showAuthor }) => (
	<article className="h-entry" style={{borderBottom: '1px solid black', paddingBottom: '2em'}}>
		{showAuthor && <Author />}
		<NoteContent note={note} />
		<footer>
			<ActivitySummary activities={note._activityMeta} />
			{note.publishedAt && <PublishedAt note={note} /> }
			<SyndicationLinks note={note} />
		</footer>
	</article>
)

NoteListItem.defaultProps = {
	showAuthor: true,
}

NoteListItem.propTypes = {
	showAuthor: propTypes.bool.isRequired,

}

export default compose(
)(NoteListItem)
