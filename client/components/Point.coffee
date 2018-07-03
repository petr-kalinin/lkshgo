React = require('react')

import { connect } from 'react-redux'

import distance from '../lib/distance'

export default class Point extends React.Component
    distance: () ->
        r = distance(@props.point.coords[0], @props.point.coords[1], @props.coords[0], @props.coords[1])
        return r

    render: () ->
        <div>
            {@props.point.name + " "}
            {@distance() + " "}
            {@props.coords}
        </div>
