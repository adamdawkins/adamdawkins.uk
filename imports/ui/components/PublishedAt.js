import React from 'react'
import moment from 'moment'

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

export default PublishedAt
