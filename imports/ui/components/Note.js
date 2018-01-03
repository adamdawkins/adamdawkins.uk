import React from 'react'
import { compose, mapProps } from 'recompose'
import { merge } from 'ramda'


const Note = ({ note }) => (
	<div dangerouslySetInnerHTML={note.content} /> // eslint-disable-line react/no-danger
)

/* To render HTML from code, we have to pass it to `dangerouslySetInnerHTML` as `{__html: HTML}`
 * We do this with the `content` prop from the note, which we get in HTML format from graphql.
 * See https://reactjs.org/docs/dom-elements.html#dangerouslysetinnerhtml
*/
const htmlifyNoteContent = mapProps((props) => {
	const { note } = props
	const newNote = merge(note, { content: { __html: note.content } })
	return merge(props, { note: newNote })
})

export default compose(
	htmlifyNoteContent,
)(Note)
