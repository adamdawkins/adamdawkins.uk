import React from 'react'

const AdamCard = () => (
	<div className="card h-card">
		<div className="row">
			<div className="col 4">
				<a className="u-url u-uid" href="/">
					<img className="u-photo" src="/profile.png" alt="Adam Dawkins" />
				</a>
			</div>
			<div className="col 8">
				<p className="p-note">Hi, I'm <span className="p-name">Adam<span style={{display: 'none' }}>Dawkins</span></span>.
					I'm a web developer &amp; co-founder at <a className="org url fn" href="http://www.dragondrop.uk">Dragon Drop</a>. </p>
				<p>I write about development, politics, and faith in my <a href="https://medium.com/@adamdawkins" rel="me">articles</a>.
					I keep my <a href="/notes">notes here</a> and on <a href="https://www.twitter.com/adamdawkins">Twitter</a>.
					Email me at <a className="u-email" href="mailto:adam@dragondrop.uk" rel="me">adam@dragondrop.uk</a></p>
			</div>
		</div>
	</div>
)

export default AdamCard
