import 'User'
import 'ApplicationController'

class UsersController extends ApplicationController
  before_action ((next) ->
    User.where(_id: @params.id).first (err, user) =>
      return next(err) if err?
      return next(new Error('Could not find user')) unless user?
      @user = user
      next()
  ), only: ['show']

  index: ->
    @users = User.array()
    
    if @params.format is 'json'
      @render(json: {users: @users})
    else
      @render()
  
  show: ->
    if @params.format is 'json'
      @render(json: @user)
    else
      @render()
  
  new: -> @render()

  create: ->
    User.authenticate @body.email, @body.password, (err, user) =>
      if err?
        @flash.error = err.message
        return @render 'new'
      User.save {
        pagelever_id: user.id
        email: user.email
      }, =>
        @redirect_to '/users', success: "#{@body.email} has been successfully added!"
