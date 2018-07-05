export MARK_AS_PASSED = 'MARK_AS_PASSED'

export markAsPassed = (name) ->
    return
        type: MARK_AS_PASSED
        name: name
