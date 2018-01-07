import React from 'react'

const Facepile = ({ activities }) => (
	<ul className="facepile">
		{activities.map(activity => <Face key={activity.source} activity={activity} />)}
	</ul>
)

const Face = ({ activity: { type, url, author } }) => (
	<li className={`face p-${type} h-cite`}>
		<a href={url} className="u-url" data-external="true">
			<span className="p-author h-card">
				<img className="u-photo" src={author.photo} height="36" alt={author.name} />
			</span>
		</a>
		<a style={{ display: 'none' }} className="p-name u-url" href={author.url} data-external="true">{author.name}</a>
	</li>
)

export default Facepile
