React = require('react')

import { connect } from 'react-redux'

export default class Point extends React.Component
    render: () ->
        <div>
            {@props.point.name}
        </div>
