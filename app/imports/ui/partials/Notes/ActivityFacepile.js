import React from 'react'
import { graphql } from 'react-apollo'
import { compose, flattenProp } from 'recompose'

import { withLoading } from '../../helpers'
import query from './activities.graphql'

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

export default ActivityFacepile
