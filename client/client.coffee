import "babel-polyfill"

React = require('react')

ReactDOM = require('react-dom')

import { Provider } from 'react-redux'
import createStore from './redux/store'

import GeoLocator from './components/GeoLocator'

window.store = createStore({})

ReactDOM.render(
    <Provider store={window.store}>
        <div>
            <GeoLocator/>
        </div>
    </Provider>,
    document.getElementById('main')
)
