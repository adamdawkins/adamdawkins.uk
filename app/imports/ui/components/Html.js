import React from 'react'

const Html = ({content, classes, style}) => (
	<div className={classes} style={style} dangerouslySetInnerHTML={{__html: content}} />
)

export default Html
