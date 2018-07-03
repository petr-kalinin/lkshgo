React = require('react')

import { connect } from 'react-redux'

import Point from './Point'

class BasicList extends React.Component
    render: () ->
        <div>
            {@props.points.map((point) => <Point point={point} coords={@props.coords} key={point.name}/>)}
        </div>

mapStateToProps = (state) ->
    return
        points: state.points

export default connect(mapStateToProps)(BasicList)
