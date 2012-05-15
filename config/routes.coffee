module.exports = ->
  @route '/', 'application#root'

  @resources 'users'
  @resources 'shots'
