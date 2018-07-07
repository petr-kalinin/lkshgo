import { combineReducers } from 'redux'
import { PENDING, FULFILLED, REJECTED } from 'redux-promise-middleware'
deepcopy = require("deepcopy")

import { MARK_AS_PASSED, HELP, RESET } from './actions'

import track from '../data/track'
import preps from '../data/preps'
import photos from '../data/photos'

MAX_ACTIVE = 4

preps_list = () ->
    result = []
    for prep of preps
        result.push(prep)
        console.assert(prep of photos, prep)
    console.log result.length
    for i in [result.length-1...0]
        j = Math.floor(Math.random() * i)
        [result[i], result[j]] = [result[j], result[i]]
    return result

_defaultPoints = () ->
    result = []
    for i in [44..48]
        for j in [55..59]
            result.push
                passed: false,
                active: false,
                phase: 21 * i + 33 * j
                coords: [i, j],
                name: "__" + i + "" + j + "__"
                image: if i % 2 == 0 then "red" else "blue"
    return result

defaultPoints = () ->
    local = window.localStorage.getItem("points")
    if local
        return JSON.parse(local)
    all_preps = preps_list()
    result = []
    take = (0 for point in track)
    for i in [0...all_preps.length]
        while true
            idx = Math.floor(Math.random() * take.length)
            if take[idx] == 0
                take[idx] = 1
                break
    prep_i = 0
    for i in [0...take.length]
        if take[i]
            result.push
                passed: false,
                active: false,
                phase: Math.floor(Math.random() * 1000)
                coords: track[i],
                name: preps[all_preps[prep_i]]
                image: all_preps[prep_i]
            prep_i++
    console.assert(prep_i == all_preps.length)
    return result


points = (state = defaultPoints(), action) ->
    state = deepcopy(state)
    if action.type == RESET
        window.localStorage.removeItem("points")
        state = defaultPoints()

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

    window.localStorage.setItem("points", JSON.stringify(state))
    return state

help = (state = false, action) ->
    if action.type == HELP
        action.value
    else
        state

export default rootReducer =
    combineReducers {
        points,
        help
    }
