export MARK_AS_PASSED = 'MARK_AS_PASSED'
export HELP = 'HELP'

export markAsPassed = (name) ->
    return
        type: MARK_AS_PASSED
        name: name

export help = (value) ->
    return
        type: HELP
        value: value
