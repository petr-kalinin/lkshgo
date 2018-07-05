React = require('react')
deepcopy = require("deepcopy")

import { connect } from 'react-redux'

import distance from '../lib/distance'

THRESHOLD_DISTANCE = 10
DISTANCE_TIME = 5

export default class Point extends React.Component
    constructor: (props) ->
        super(props)
        @state =
            distances: [{time: 0, distance: 1e10}]

    distance: () ->
        r = distance(@props.point.coords[0], @props.point.coords[1], @props.coords[0], @props.coords[1])
        return r

    render: () ->
        className = "passive"
        if @props.point.active
            className = "active"
        if @props.point.passed
            className = "passed"
        <div className={className}>
            {@props.time + " "}
            {@props.point.name + " "}
            {@distance() + " "}
            {@props.coords + " "}
            {@props.point.coords + " "}
            {" active=" + @props.point.active}
            {" passed=" + @props.point.passed}
            {@state.distances.map((s) -> "#{s.time}:#{s.distance} ")}
        </div>

    componentDidUpdate: () ->
        if (@props.point.active and !@props.point.passed and @distance() < THRESHOLD_DISTANCE)
            @props.markAsPassed()
        if (@props.time and @props.time > @state.distances[@state.distances.length - 1].time)
            newDistances = (p for p in @state.distances when p.time > @props.time - DISTANCE_TIME)
            newDistances.push
                time: @props.time
                distance: @distance()
            @setState
                distances: newDistances
