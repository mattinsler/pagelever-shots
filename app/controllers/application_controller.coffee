class ApplicationController extends Controller
  helper {moment: require 'moment'}
  # before_action (next) ->
  #   @params.format = 'json'
  #   next()
  
  root: ->
    @redirect_to '/shots'
