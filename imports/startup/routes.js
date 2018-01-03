import React from 'react'
import { Switch, Route } from 'react-router-dom'
import Home from '../ui/pages/Home/Home'
import Notes from '../ui/pages/Notes/Notes'
import ShowNote from '../ui/pages/ShowNote/ShowNote'

const Routes = () => (
	<Switch>
		<Route exact path="/" component={Home} />
		<Route exact path="/notes" component={Notes} />
		<Route exact path="/notes/:id" component={ShowNote} />
	</Switch>
)

export default Routes
