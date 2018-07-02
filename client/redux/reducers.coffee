import { combineReducers } from 'redux'
import { PENDING, FULFILLED, REJECTED } from 'redux-promise-middleware'

import { SET_UNPAID_WARNING_SHOWN } from './actions'

unpaidWarningShown = (state = false, action) ->
    if action.type == SET_UNPAID_WARNING_SHOWN
        return true
    else
        return state


export default rootReducer =
    combineReducers {
        unpaidWarningShown,
    }
