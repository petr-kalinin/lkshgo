React = require('react')

import { connect } from 'react-redux'

import * as actions from '../redux/actions'

import Point from './Point'

class BasicList extends React.Component
    render: () ->
        <div>
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

mapDispatchToProps = (dispatch) ->
    return
        markAsPassed: (name) -> dispatch(actions.markAsPassed(name))

export default connect(mapStateToProps, mapDispatchToProps)(BasicList)
