React = require('react')

import { geolocated } from 'react-geolocated';

import BasicList from './BasicList'

export default class TimeProvider extends React.Component
    constructor: (props) ->
        super(props)
        @update = @update.bind this
        
    time: () ->
        Math.floor((new Date()) / 1000)

    render: () ->
        `<BasicList {...this.props} {...this.state}/>`

    update: () ->
        @setState
            time: @time()

    componentDidMount: () ->
        @interval = setInterval(@update, 100)

    componentWillMount: () ->
        if @interval
            clearInterval(@interval)
