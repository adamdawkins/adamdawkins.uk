import React from 'react'
import propTypes from 'prop-types'

const SyndicationLink = ({ url, name }) => <a href={url} className="u-syndication">{name}</a>

SyndicationLink.propTypes = {
	url: propTypes.string.isRequired,
	name: propTypes.string.isRequired,
}

export default SyndicationLink
