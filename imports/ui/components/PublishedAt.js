import React from 'react'
import propTypes from 'prop-types'
import moment from 'moment'

const PublishedAt = ({ date, url }) => {
	const dateMoment = moment(date, moment.ISO_8601)
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

PublishedAt.propTypes = {
	date: propTypes.string.isRequired,
	url: propTypes.string.isRequired,
}

export default PublishedAt
