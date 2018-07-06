import { combineReducers } from 'redux'
import { PENDING, FULFILLED, REJECTED } from 'redux-promise-middleware'
deepcopy = require("deepcopy")

import { MARK_AS_PASSED } from './actions'

MAX_ACTIVE = 4

defaultPoints = () ->
    result = []
    for i in [44..48]
        for j in [55..59]
            result.push
                passed: false,
                active: false,
                phase: 21 * i + 33 * j
                coords: [i, j],
                name: "__" + i + "" + j + "__"
    return result


points = (state = defaultPoints(), action) ->
    state = deepcopy(state)
    if action.type == MARK_AS_PASSED
        for point in state
            if point.name == action.name
                point.passed = true

    nNotPassed = 0
    for point in state
        if point.passed
            point.active = false
        else
            point.active = (nNotPassed < MAX_ACTIVE)
            nNotPassed += 1

    return state

export default rootReducer =
    combineReducers {
        points
    }
