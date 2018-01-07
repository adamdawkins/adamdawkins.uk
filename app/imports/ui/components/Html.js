import React from 'react'

const Html = ({content, classes}) => (
	<div className={classes} dangerouslySetInnerHTML={{__html: content}} />
)

export default Html
