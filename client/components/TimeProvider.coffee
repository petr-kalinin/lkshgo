React = require('react')

import currentTime from '../lib/currentTime'

import BasicList from './BasicList'

export default class TimeProvider extends React.Component
    constructor: (props) ->
        super(props)
        @update = @update.bind this

    render: () ->
        `<BasicList {...this.props} {...this.state}/>`

    update: () ->
        @setState
            time: currentTime()

    componentDidMount: () ->
        @interval = setInterval(@update, 100)

    componentWillMount: () ->
        if @interval
            clearInterval(@interval)
