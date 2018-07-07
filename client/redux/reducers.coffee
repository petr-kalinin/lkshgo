import { combineReducers } from 'redux'
import { PENDING, FULFILLED, REJECTED } from 'redux-promise-middleware'
deepcopy = require("deepcopy")

import { MARK_AS_PASSED } from './actions'

import track from '../data/track'

MAX_ACTIVE = 4

NUM_POINTS = 20

defaultPoints = () ->
    result = []
    take = (0 for point in track)
    for i in [0..NUM_POINTS]
        while true
            idx = Math.floor(Math.random() * take.length)
            if take[idx] == 0
                take[idx] = 1
                break
    for i in [0..take.length]
        if take[i]
            result.push
                passed: false,
                active: false,
                phase: Math.floor(Math.random() * 1000)
                coords: track[i],
                name: "__" + i
                image: if i % 2 == 0 then "red" else "blue"
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
