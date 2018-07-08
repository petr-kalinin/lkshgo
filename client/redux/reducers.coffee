import { combineReducers } from 'redux'
import { PENDING, FULFILLED, REJECTED } from 'redux-promise-middleware'
deepcopy = require("deepcopy")

import { MARK_AS_PASSED, HELP, UNDO_RESET, REDO_RESET, RESET } from './actions'

import track, {secretPoints} from '../data/track'
import preps, {secretPreps} from '../data/preps'
import photos from '../data/photos'
import distance from '../lib/distance'

MAX_ACTIVE = 4
SECRET_PREP_OFFSET = 40

preps_list = () ->
    result = []
    for prep of preps
        result.push(prep)
        console.assert(prep of photos, prep)
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
                secret: false,
                phase: 21 * i + 33 * j
                coords: [i, j],
                name: "__" + i + "" + j + "__"
                image: if i % 2 == 0 then "red" else "blue"
    for i in [50..55]
        for j in [55..55]
            result.push
                passed: false,
                active: false,
                secret: true,
                phase: 21 * i + 33 * j
                coords: [i, j],
                name: "__" + i + "" + j + "__"
                image: if i % 2 == 0 then "red" else "blue"
    return result

makeSecretPreps = () ->
    result = []
    for prep of secretPreps
        console.assert(prep of photos, "photos " + prep)
        console.assert(prep of secretPoints, "secretPoints " + prep)
        center = secretPoints[prep]
        points = []
        for point in track
            if distance(center[0], center[1], point[0], point[1]) < SECRET_PREP_OFFSET
                points.push(point)
        console.assert(points.length > 0)
        idx = Math.floor(Math.random() * points.length)
        result.push
            passed: false,
            active: false,
            secret: true,
            phase: Math.floor(Math.random() * 1000)
            coords: points[idx],
            name: secretPreps[prep]
            image: prep
    return result

defaultPoints = () ->
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
                secret: false,
                phase: Math.floor(Math.random() * 1000)
                coords: track[i],
                name: preps[all_preps[prep_i]]
                image: all_preps[prep_i]
            prep_i++
    console.assert(prep_i == all_preps.length)
    result = result.concat(makeSecretPreps())
    return result

initialState = () ->
    local = window.localStorage.getItem("points")
    if local
        local = JSON.parse(local)
        if local.prev?.length >= 0
            return local
    return {current: defaultPoints(), prev: [], next: []}

points = (state = initialState(), action) ->
    state = deepcopy(state)
    if action.type == RESET
        state.prev.push(state.current)
        state.current = defaultPoints()
    else if action.type == UNDO_RESET and state.prev.length > 0
        state.next.push(state.current)
        state.current = state.prev.pop()
    else if action.type == REDO_RESET and state.next.length > 0
        state.prev.push(state.current)
        state.current = state.next.pop()

    if action.type == MARK_AS_PASSED
        for point in state.current
            if point.name == action.name
                point.passed = true

    nNotPassed = 0
    for point in state.current
        if point.passed
            point.active = false
        else
            point.active = (nNotPassed < MAX_ACTIVE) or point.secret
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
