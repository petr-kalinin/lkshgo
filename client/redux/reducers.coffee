import { combineReducers } from 'redux'
import { PENDING, FULFILLED, REJECTED } from 'redux-promise-middleware'
deepcopy = require("deepcopy")

import { MARK_AS_PASSED } from './actions'

defaultPoints = [{
    passed: false,
    active: false,
    coords: [44, 55],
    name: "Пройден"
}, {
    passed: false,
    active: true,
    coords: [44, 56],
    name: "Текущий"
}, {
    passed: false,
    active: false,
    coords: [45, 55],
    name: "Будущий"
}
]


points = (state = defaultPoints, action) ->
    state = deepcopy(state)
    if action.type == MARK_AS_PASSED
        for point in state
            if point.name == action.name
                point.passed = true

    return state

export default rootReducer =
    combineReducers {
        points
    }
