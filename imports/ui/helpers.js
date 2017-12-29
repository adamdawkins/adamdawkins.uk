import React from 'react'
import { mapProps, branch, renderComponent } from 'recompose'

import Loader from './components/Loader/Loader'

/* withLoading :: <Component props={..., data: { loading }...} /> -> Maybe(<Loader/>)

 * withLoading will return the <Loader> component if the data.loading prop is true.
 * Using this after importing data from graphql removes the need to handle data loading
 * within components themselves.
 */
export const withLoading = branch(
	props => props.data.loading,
	renderComponent(() => <Loader />),
)

/* logProps :: String -> Boolean -> Void
 * logs all props for a component.
 * - name: String 		- a name for the component, will appear in the log
 * - showLog: Boolean - props will only be logged if true, this allows developers
 *  									  to leave `logProps` in for a component without seeing
 *  									  the output in the console.
 */

export const logProps = (name, showLog = true) => mapProps((props) => {
	if (showLog) {
		console.log(`${name} props`, props) // eslint-disable-line no-console
	}

	return props
})
