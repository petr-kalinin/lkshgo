export MARK_AS_PASSED = 'MARK_AS_PASSED'
export RESET = 'RESET'
export HELP = 'HELP'
export UNDO_RESET = 'UNDO_RESET'
export REDO_RESET = 'REDO_RESET'

export markAsPassed = (name) ->
    return
        type: MARK_AS_PASSED
        name: name

export reset = () ->
    return
        type: RESET

export undoReset = () ->
    return
        type: UNDO_RESET

export redoReset = () ->
    return
        type: REDO_RESET

export help = (value) ->
    return
        type: HELP
        value: value
