export MARK_AS_PASSED = 'MARK_AS_PASSED'
export RESET = 'RESET'
export HELP = 'HELP'

export markAsPassed = (name) ->
    return
        type: MARK_AS_PASSED
        name: name

export reset = (name) ->
    return
        type: RESET

export help = (value) ->
    return
        type: HELP
        value: value
