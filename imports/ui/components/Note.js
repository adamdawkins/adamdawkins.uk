import React from 'react'
import { compose, mapProps } from 'recompose'


const Note = ({ note }) => (
	<div dangerouslySetInnerHTML={{ __html: note.content }} style={{borderBottom: '1px solid black', paddingBottom: '2em'}}/> // eslint-disable-line react/no-danger
)

/* To render HTML from code, we have to pass it to `dangerouslySetInnerHTML` as `{__html: HTML}`
 * We do this with the `content` prop from the note, which we get in HTML format from graphql.
 * See https://reactjs.org/docs/dom-elements.html#dangerouslysetinnerhtml
*/
export default compose(
)(Note)
