React = require('react')

import { connect } from 'react-redux'

import * as actions from '../redux/actions'

import Point from './Point'
import Help from './Help'

class BasicList extends React.Component
    count: () ->
        result = 0
        for point in @props.points
            if point.passed
                result++
        return result

    render: () ->
        if @props.help
            return <Help close={@props.closeHelp}/>
        <div>
            <div className="topbar">
                <div className="total">{@count() + "/" + @props.points.length}</div>
                <div className="button" onClick={@props.reset}>reset</div>
                <div className="help button" onClick={@props.showHelp}>?</div>
            </div>
            {@props.points.map((point) =>
                <Point point={point}
                       coords={@props.coords}
                       time={@props.time}
                       markAsPassed={() => @props.markAsPassed(point.name)}
                       key={point.name}
                       />
            )}
        </div>

mapStateToProps = (state) ->
    return
        points: state.points
        help: state.help

mapDispatchToProps = (dispatch) ->
    return
        markAsPassed: (name) -> dispatch(actions.markAsPassed(name))
        reset: (name) -> dispatch(actions.reset())
        showHelp: (name) -> dispatch(actions.help(true))
        closeHelp: (name) -> dispatch(actions.help(false))

export default connect(mapStateToProps, mapDispatchToProps)(BasicList)
