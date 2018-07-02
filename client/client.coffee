import "babel-polyfill"

React = require('react')

ReactDOM = require('react-dom')

import { Provider } from 'react-redux'

import createStore from './redux/store'

ReactDOM.render(
    <Provider store={window.store}>
        <div>
            <h1>OK</h1>
        </div>
    </Provider>,
    document.getElementById('main')
)
