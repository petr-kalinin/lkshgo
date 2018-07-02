React = require('react')

import { geolocated } from 'react-geolocated';

class Locator extends React.Component
    render: () ->
        if !this.props.isGeolocationAvailable
            <div>Your browser does not support Geolocation</div>
        else if !this.props.isGeolocationEnabled
            <div>Geolocation is not enabled</div>
        else if !this.props.coords
            <div>Getting the location data&hellip;</div>
        else
            <table>
                <tbody>
                    <tr><td>latitude</td><td>{this.props.coords.latitude}</td></tr>
                    <tr><td>longitude</td><td>{this.props.coords.longitude}</td></tr>
                    <tr><td>altitude</td><td>{this.props.coords.altitude}</td></tr>
                    <tr><td>heading</td><td>{this.props.coords.heading}</td></tr>
                    <tr><td>speed</td><td>{this.props.coords.speed}</td></tr>
                </tbody>
            </table>

options =
    watchPosition: true

export default geolocated(options)(Locator);
