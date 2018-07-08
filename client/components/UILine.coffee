React = require('react')

import images from '../data/images'
import photos from '../data/photos'

SECRET_DISTANCE = 40

export default class UILine extends React.Component

    signal: (distance) ->
        if distance < 15
            undefined
        else if distance < 30
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
        {status, distance, velocity, image, name, silenceTime, secret} = @props
        if status == "passive"
            return null

        signal = @signal(distance)
        velocity = @velocity(velocity)
        divclass = "uiline"

        timestring = "Активен: " + silenceTime

        if status == "passed"
            signal = "passed"
            velocity = "silent"
        else if status == "silent"
            signal = "silent"
            velocity = "silent"
            divclass += " silent"
            timestring = "Ожидание: " + silenceTime
        if secret and distance > SECRET_DISTANCE
            signal = "silent"
            velocity = "silent"
            divclass += " silent"
            name = "Секретный преподаватель"
            timestring = ""
            image = "silent"

        if image of images
            photo = "data:image/png;base64, " + images[image]
        else
            photo = "data:image/joeg;base64, " + photos[image]

        <div className={divclass}>
            <img className="photo" src={photo}/>
            <div className="namepart">
                <div className="name">{name}</div>
                {if status != "passed"
                    <div className="silenceTime">{timestring}</div>
                }
            </div>
            <img className="velocity" src={"data:image/png;base64, " + images[velocity]}/>
            {if signal
                <img className="signal" src={"data:image/png;base64, " + images[signal]}/>
            else
                <div className="distance">{distance.toFixed(0)}</div>
            }
        </div>
