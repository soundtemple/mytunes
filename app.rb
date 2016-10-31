require 'sinatra'
require 'id3tag'
# require 'sinatra/reloader'
require 'pry'
require 'Base64'
require_relative 'db_config'
require_relative 'models/user'

enable :sessions

helpers do
# double negation. turns object to true or false
  def logged_in?
    !!current_user
  end

# finds id of current user
  def current_user
    User.find_by(id: session[:user_id])
  end
end

# create new session
get '/session/new' do
  erb :account
end

# authenticate session
post '/session' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    # you are fine
    session[:user_id] = user.id
    redirect to '/'
  else
    @message = "Could not log in with those details"
    @type = "warning"
    erb :account
  end
end

# logout
delete '/session' do
  session[:user_id] = nil
  @message = "You have been logged out."
  @type = "success"
  erb :account
end

# new user
post '/new_user' do
  user = User.find_by(email: params[:email])
  if user
    @message = "User already exists with that email"
    @type = "warning"
    erb :account

  elsif params[:password] != params[:password_confirm]
    @message = "Passwords do not match"
    @type = "warning"
    erb :account
  else
    new_user = User.new
    new_user.email = params[:email]
    new_user.username = params[:username]
    new_user.password = params[:password]
    new_user.save
    @message = "Success. Welcome to myTunes."
    @type = "success"
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
    end
    erb :account
  end
end


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
