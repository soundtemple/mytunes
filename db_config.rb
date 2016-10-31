require 'active_record'



options = {
  adapter: 'postgresql',
  database: 'mytunes'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
