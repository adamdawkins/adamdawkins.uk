import React from 'react'
import moment from 'moment'
import { compose } from 'recompose'

import Author from './Author'

const Note = ({ note, showAuthor }) => (
	<article className="h-entry" style={{borderBottom: '1px solid black', paddingBottom: '2em'}}>
		{showAuthor && <Author />}
		<div className="e-content p-name" dangerouslySetInnerHTML={{ __html: note.content }}/>
		<footer>
			{note.publishedAt && <PublishedAt note={note} /> }
		</footer>
	</article>
)

Note.defaultProps = {
	showAuthor: true,
}


const PublishedAt = ({ note: { publishedAt, url } }) => {
	const dateMoment = moment(publishedAt, moment.ISO_8601)
	return (
		<p>Published&nbsp;
			<a
				className="u-url"
				href={url}
				title={dateMoment.format('Do MMMM YYYY')}
			>
				<time
					className="dt-published"
					dateTime={dateMoment.format()}
				>
					{dateMoment.fromNow()}
				</time>
			</a>
		</p>
	)
}


export default compose(
)(Note)
