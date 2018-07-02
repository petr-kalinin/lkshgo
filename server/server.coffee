require('source-map-support').install()

import csshook from 'css-modules-require-hook/preset'

express = require('express')
passport = require('passport')
compression = require('compression')

import logger from './log'

process.on 'unhandledRejection', (r) ->
    logger.error "Unhandled rejection "
    logger.error r

app = express()
app.enable('trust proxy')

app.use(compression())

app.use(express.static('build/assets'))

app.use(express.static('public'))

app.get '/status', (req, res) ->
    logger.info "Query string", req.query
    res.send "OK"

app.get '/', (req, res) ->
    res.redirect('/index.html')

port = (process.env.OPENSHIFT_NODEJS_PORT || process.env.PORT || 3000)
app.listen port, () ->
    console.log 'App listening on port ', port
    logger.info 'App listening on port ', port
