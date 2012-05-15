class ApplicationController extends Controller
  helper {moment: require 'moment'}
  
  before_action (next) ->
    @session.auth_token = @query.auth_token if @query.auth_token?
    return @unauthorized() unless @session.auth_token is Caboose.app.config.auth_token
    next()
  
  root: ->
    @redirect_to '/shots'
