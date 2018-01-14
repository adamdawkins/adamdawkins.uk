import React from 'react'
import propTypes, { shape } from 'prop-types'

import Html from './Html'

const NoteContent = ({ note: { content } }) => (
	<Html style={{ fontSize: '1.2em' }} classes="e-content p-name" content={content} />
)

NoteContent.propTypes = {
	note: shape({
		content: propTypes.string.isRequired,
	}).isRequired,
}

export default NoteContent
