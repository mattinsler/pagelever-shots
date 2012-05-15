import 'Shot'
import 'User'
import 'ApplicationController'

class ShotsController extends ApplicationController
  before_action ((next) ->
    Shot.where(_id: @params.id).first (err, shot) =>
      return next(err) if err?
      return next(new Error('Could not find shot')) unless shot?
      @shot = shot
      next()
  ), only: ['show']
  
  index: ->
    @shots = Shot.array()
    
    if @params.format is 'json'
      @render(json: @shots)
    else
      @render()
  
  show: ->
    if @params.format is 'json'
      @render(json: @shot)
    else
      @render()
  
  create: ->
    User.where(_id: @body.user_id).first (err, user) =>
      return @error(err) if err?
      return @error(new Error('Could not find user')) unless user?

      Shot.save {
        user: {
          id: user._id
          email: user.email
        }
        received_at: new Date()
      }, (err, shot) =>
        return @error(err) if err?
        user.update($inc: {shots_received: 1})
        if @params.format is 'json'
          @render(json: shot)
        else
          @redirect_to "/shots/#{shot._id}"
