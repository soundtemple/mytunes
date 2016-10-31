require 'sinatra'
# require 'sinatra/reloader'
require 'pry'
require_relative 'db_config'

enable :sessions


get '/' do
  erb :index
end

get '/up_next' do
  erb :up_next
end

get '/playlists' do
  erb :playlists
end

get '/albums' do
  erb :albums
end

get '/songs' do
  erb :songs
end

get '/tags' do
  erb :tags
end

get '/new' do
  erb :add_new
end

get '/account' do
  erb :account
end

get '/about' do
  erb :about
end
