React = require('react')

import { geolocated } from 'react-geolocated';

import BasicList from './BasicList'

class Locator extends React.Component
    render: () ->
        if !this.props.isGeolocationAvailable
            <div>Your browser does not support Geolocation</div>
        else if !this.props.isGeolocationEnabled
            <div>Geolocation is not enabled</div>
        else if !this.props.coords
            <div>Getting the location data&hellip;</div>
        else
            <BasicList coords={[@props.coords.longitude, @props.coords.latitude]} />

options =
    watchPosition: true

export default geolocated(options)(Locator);
