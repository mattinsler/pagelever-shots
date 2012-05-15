pg = Caboose.app.postgres
bcrypt = require 'bcrypt'

class User extends Model
  store_in 'users'
  
  property 'full_name', ->
    "#{@first_name} #{@last_name}"
  
  static 'authenticate', (email, password, callback) ->
    pg.connect (err, client) ->
      return callback(err) if err?
      
      client.query 'SELECT * FROM users WHERE email = $1', [email], (err, result) ->
        return callback(err) if err?
        return callback(new Error('Could not authenticate')) if result.rows.length is 0
        user = result.rows[0]
        
        bcrypt.compare password, user.password_hash, (err, res) ->
          return callback(err) if err?
          return callback(new Error('Could not authenticate')) unless res
          callback(null, result.rows[0])
