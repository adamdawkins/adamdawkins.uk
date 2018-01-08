import React from 'react'

const ActivitySummary = ({ activities }) => (
	<div style={{display: 'flex', flexDirection: 'row', justifyContent: 'flex-start'}}>
		{activities.map(activity => <ActivityCount key={activity.type} {...activity} />)}
	</div>
)

const iconForType = (type) => {
	switch (type) {
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

const ActivityCount = ({ type, count }) => (
	<div style={{ margin: '0 1em', fontSize: '.8em', display: 'flex', alignItems: 'center', fontFamily: 'monospace' }} title={`${type}s`}>
		<i className={`${iconForType(type)} fa-pull-left`} />
		<span>{count}</span>
	</div>
)

export default ActivitySummary
