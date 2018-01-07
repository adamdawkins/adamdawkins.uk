import React from 'react'

import PublishedAt from './PublishedAt'

const Activity = ({ activity }) => (
	<article className="p-like h-cite" style={{display: 'flex', flexDirection: 'row'}}>
		<a className="p-author h-card p-url" href={activity.author.url} dataExternal style={{width: '2em', marginRight: '1em', display: 'flex', flexDirection: 'column' }}>
			<img src={activity.author.photo} alt={activity.author.name} style={{maxWidth: '100%', height: 'auto'}}/>
			<span className="p-name">{activity.author.name}</span>
		</a>
		<a className="p-author" href={activity.author.url}>{activity.author.name}</a> {activity.type} this.
		<PublishedAt url={activity.url} date={activity.publishedAt} />
	</article>
)


export default Activity
