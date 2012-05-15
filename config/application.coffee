module.exports = (config, next) ->
  config.http =
    enabled: true
    port: process.env.PORT || 3000
  
  config.auth_token = process.env.AUTH_TOKEN || 'test'

  next()
