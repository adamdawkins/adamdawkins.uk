import React from 'react'
import { graphql } from 'react-apollo'
import { propType } from 'graphql-anywhere'
import { compose, flattenProp } from 'recompose'

import { withLoading } from '../../helpers'
import query from './note.graphql'

import NoteContent from '../../components/NoteContent'
import SyndicationLinks from '../../components/SyndicationLinks'
import PublishedAt from '../../components/PublishedAt'
import ActivityFacepile from '../../partials/Notes/ActivityFacepile'
import SyndicateTargets from '../../partials/Notes/SyndicateTargets'
import ActivitySummary from '../../components/ActivitySummary'

import AdamCard from '../../partials/AdamCard'

const ShowNote = ({ note }) => (
	<div className="c">
    <h1 className="title"><a href="/">Adam Dawkins</a></h1>
		<main className="row">
    <div className="col 2"/>
    <div className="col 8">
			<article className="h-entry card">
				<NoteContent note={note} />
				{note.photo && (<img src={note.photo} alt="{note.content}" />)}
				<footer className="row">
          <div className="row Fz(small) Ff(ss)">
            <div className="col 6">
              <PublishedAt date={note.publishedAt} url={note.url} />
            </div>
            <div className="col 6">
            <SyndicationLinks note={note} />
            </div>
          </div>
					<ActivitySummary activities={note._activityMeta} />
					<div style={{ display: 'flex', flexDirection: 'column' }}>
						<ActivityFacepile type="like" activities={note.likes} />
						<ActivityFacepile type="repost" activities={note.reposts} />
					</div>
					{ note.categories && (
					<div>
					<hr />
						<p className="Fz(small) Ff(ss)">Posted in {note.categories.map(cat => (<a key={cat} href={`/notes/categories/${cat}`} style={{ marginRight: '.5em' }}>{cat}</a>))}</p>
					</div>
					)}
				</footer>
				<a href="/" className="u-author" rel="author" />
				<data class="p-bridgy-omit-link" value="maybe" />
			</article>
			<SyndicateTargets note={note} />
    </div>
    <div className="col 2"/>
		</main>
    <footer className="row" style={{marginTop: '6em'}}>
    <div className="col 3"/>
      <div className="col 6">
        <AdamCard />
      </div>
    <div className="col 3"/>
    </footer>
	</div>
)

ShowNote.propTypes = {
	note: propType(query),
}

const data = graphql(query, {
	options: ({ match: { params: { id } } }) => ({ variables: { id } }),
})

export default compose(
	data,
	withLoading,
	flattenProp('data'),
)(ShowNote)
