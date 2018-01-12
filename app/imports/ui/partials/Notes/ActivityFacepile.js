import React from 'react'
import propTypes from 'prop-types'
import { propType } from 'graphql-anywhere'

import activity from './activityEssentialsFragment.graphql'

import Facepile from '../../components/Facepile'

const ActivityFacepile = ({ type, activities }) => (
	<div className="row Mt(space)">
		<div className="col 1">
			<ActivityIcon type={type} />
		</div>
		<div className="col 11">
			<Facepile activities={activities} />
		</div>
	</div>
)

ActivityFacepile.propTypes = {
	type: propTypes.string.isRequired,
	activities: propTypes.arrayOf(propType(activity)),
}

ActivityFacepile.defaultProps = {
	activities: [],
}

const ActivityIcon = ({ type, classes }) => {
	const iconForType = (activityType) => {
		switch (activityType) {
		case 'repost':
			return 'fas fa-retweet'
		case 'like':
			return 'far fa-heart'
		case 'reply':
			return 'fas fa-reply'
		case 'mention':
			return 'far fa-comment'
		default:
			return 'far fa-comment-alt'
		}
	}

	return (
		<i className={`${classes} ${iconForType(type)}`} />
	)
}

ActivityIcon.propTypes = {
	type: propTypes.string,
	classes: propTypes.string,
}

ActivityIcon.defaultProps = {
	type: '',
	classes: '',
}

export default ActivityFacepile
