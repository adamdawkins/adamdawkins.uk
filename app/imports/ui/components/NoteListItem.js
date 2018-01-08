import React from 'react'
import propTypes from 'prop-types'
import { compose } from 'recompose'

import Author from './Author'
import SyndicationLinks from './SyndicationLinks'
import NoteContent from './NoteContent'
import PublishedAt from './PublishedAt'

const NoteListItem = ({ note, showAuthor }) => (
	<article className="h-entry card">
		{showAuthor && <Author />}
		<NoteContent note={note} />
		<footer>
			<PublishedAt url={note.url} date={note.publishedAt} />
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
