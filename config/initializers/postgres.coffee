Caboose.app.postgres = pg = require 'pg'

if Caboose.app.config.postgres?
  config = Caboose.app.config.postgres
  if config.url
    uri = require('url').parse config.url
    config = {}
    config.host = uri.hostname
    config.port = uri.port if uri.port?
    config.database = uri.pathname.replace /^\//g, ''
    [config.user, config.password] = uri.auth.split(':') if uri.auth?    
    
  for key in ['user', 'password', 'host', 'port', 'database', 'poolSize']
    pg.defaults[key] = config[key] if config[key]?
