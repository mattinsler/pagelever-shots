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
      @render(json: @users)
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
      return @redirect_to('/users/new', error: err.message) if err?
      return @redirect_to('/users/new', error: 'You are unable to register') unless user.admin
      User.where($or: [{pagelever_id: user.id}, {email: user.email}]).count (err, count) =>
        return @redirect_to('/users/new', error: err.message) if err?
        return @redirect_to('/users/new', error: 'You are already registered') if count > 0
        User.save {
          pagelever_id: user.id
          email: user.email
          first_name: user.first_name
          last_name: user.last_name
          shots_taken: 0
          shots_received: 0
        }, (err, user) =>
          return @redirect_to('/users/new', error: err.message) if err?
          @redirect_to '/users', success: "What's up!"
