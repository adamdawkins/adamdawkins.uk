import React from 'react'
import Html from './Html'

const NoteContent = ({ note: { content } }) => (<Html classes="e-content p-name" content={content} />)

export default NoteContent
