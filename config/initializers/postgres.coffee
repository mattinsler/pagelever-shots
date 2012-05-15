pg = require 'pg'

pg.defaults.user = 'pagelever'
pg.defaults.password = 'pagelever4327'
pg.defaults.host = 'localhost'
pg.defaults.database = 'pagelever'

Caboose.app.postgres = pg
