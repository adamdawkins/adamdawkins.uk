import React from 'react'
import propTypes, { shapeOf } from 'prop-types'

import Html from './Html'

const NoteContent = ({ note: { content } }) => (
	<Html style={{ fontSize: '1.2em' }} classes="e-content p-name" content={content} />
)

NoteContent.propTypes = {
	note: shapeOf({
		content: propTypes.string.isRequired,
	}).isRequired,
}

export default NoteContent
