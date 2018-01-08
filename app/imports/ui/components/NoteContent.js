import React from 'react'
import Html from './Html'

const NoteContent = ({ note: { content } }) => (<Html style={{fontSize: '1.2em'}} classes="e-content p-name" content={content} />)

export default NoteContent
