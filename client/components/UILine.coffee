React = require('react')

import images from '../images/images'

export default class UILine extends React.Component
    render: () ->
        {status, distance, image, name} = @props
        if status == "passive"
            return null
        if status == "passed"
            signal = "passed"
        else if status == "silent"
            signal = "silent"
        else if distance < 25
            signal = "signal4"
        else if distance < 50
            signal = "signal3"
        else if distance < 100
            signal = "signal2"
        else if distance < 200
            signal = "signal1"
        else
            signal = "signal0"
        <div className="uiline">
            <img className="photo" src={"data:image/png;base64, " + image}/>
            <div className="name">{name}</div>
            <div className="velocity">V</div>
            <img className="signal" src={"data:image/png;base64, " + images[signal]}/>
        </div>
