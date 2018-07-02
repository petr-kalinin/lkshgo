import { combineReducers } from 'redux'
import { PENDING, FULFILLED, REJECTED } from 'redux-promise-middleware'

###
import { SET_UNPAID_WARNING_SHOWN } from './actions'
###

###
unpaidWarningShown = (state = false, action) ->
    if action.type == SET_UNPAID_WARNING_SHOWN
        return true
    else
        return state
###

defaultPoints = [{
    passed: true,
    active: false,
    coords: [44, 55],
    name: "Пройден"
}, {
    passed: false,
    active: true,
    coords: [45, 56],
    name: "Текущий"
}, {
    passed: false,
    active: false,
    coords: [47, 57],
    name: "Будущий"
}
]


points = (state = defaultPoints, action) ->
    return state

export default rootReducer =
    combineReducers {
        points
    }
