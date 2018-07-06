React = require('react')

import images from '../images/images'

export default class UILine extends React.Component

    signal: (distance) ->
        if distance < 25
            "signal4"
        else if distance < 50
            "signal3"
        else if distance < 100
            "signal2"
        else if distance < 200
            "signal1"
        else
            "signal0"

    velocity: (velocity) ->
        velocity = velocity / 1000 * 3600
        if velocity < -1
            "velocity_reverse"
        else if velocity < 1
            "velocity_0"
        else if velocity < 3
            "velocity_1"
        else
            "velocity_2"

    render: () ->
        {status, distance, velocity, image, name, silenceTime} = @props
        if status == "passive"
            return null

        signal = @signal(distance)
        velocity = @velocity(velocity)
        divclass = "uiline"

        if status == "passed"
            signal = "passed"
            velocity = "silent"
        else if status == "silent"
            signal = "silent"
            velocity = "silent"
            divclass += " silent"

        <div className="uiline">
            <img className="photo" src={"data:image/png;base64, " + image}/>
            <div className="name">{name}<div className="silenceTime">{silenceTime}</div></div>
            <img className="velocity" src={"data:image/png;base64, " + images[velocity]}/>
            <img className="signal" src={"data:image/png;base64, " + images[signal]}/>
        </div>
