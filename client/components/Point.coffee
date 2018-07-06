React = require('react')
deepcopy = require("deepcopy")

import { connect } from 'react-redux'

import distance from '../lib/distance'

THRESHOLD_DISTANCE = 10
DISTANCE_TIME = 5
LOOP_TIME = 3 * 10
SILENT_LOOP_TIME = 1 * 10

export default class Point extends React.Component
    constructor: (props) ->
        super(props)
        @state =
            distances: [{time: 0, distance: 1e10}]

    distance: () ->
        r = distance(@props.point.coords[0], @props.point.coords[1], @props.coords[0], @props.coords[1])
        return r

    velocity: () ->
        if @state.distances.length > DISTANCE_TIME / 2
            start = @state.distances[0]
            end = @state.distances[@state.distances.length - 1]
            dist = start.distance - end.distance
            time = start.time - end.time
            return -dist / time
        else
            return undefined

    isSilent: () ->
        phase = @props.point.phase + @props.time
        return phase % LOOP_TIME < SILENT_LOOP_TIME

    render: () ->
        if @props.point.passed
            className = "passed"
        else if @isSilent()
            className = "silent"
        else if @props.point.active
            className = "active"
        else
            className = "passive"
        <div className={className}>
            {@props.time + " "}
            {@props.point.name + " "}
            {@distance() + " "}
            {@props.coords + " "}
            {@props.point.coords + " "}
            {" active=" + @props.point.active}
            {" passed=" + @props.point.passed}
            {" velocity=" + @velocity()}
            {" distances=" + @state.distances.map((s) -> "#{s.time}:#{s.distance} ")}
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
