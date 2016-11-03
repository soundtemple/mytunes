require 'sinatra'
require 'id3tag'
require 'sinatra/reloader'
require 'pry'
require 'Base64'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'fog'
require_relative 'db_config'
require_relative 'fog_credentials'
require_relative 'models/user'
require_relative 'models/song'

enable :sessions

helpers do
# double negation. turns object to true or false
  def logged_in?
    !!current_user
  end

  # track where user came from
  def origin_path(last_page)
    session[:origin_path] = last_page
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
    @errors = ["Could not log in with those details"]
    @type = "warning"
    erb :account
  end
end

# logout
delete '/session' do
  session[:user_id] = nil
  @errors = ["You have been logged out."]
  @type = "success"
  erb :account
end

# new user
post '/new_user' do
  @type = "warning"
  new_user = User.new
  new_user.email = params[:email]
  new_user.username = params[:username]
  new_user.password = params[:password]
  if !new_user.valid?
    @errors = new_user.errors.messages
    return erb :account
  elsif new_user.valid?
    new_user.save
    @errors = ["Success. Welcome to myTunes."]
    @type = "success"
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
    end
    erb :account
  end
end

get '/account_update' do
  erb :account_update
end

post '/account_update' do
  @type = "warning"
  update_user = User.find(current_user.id)
  update_user.username = params[:username]
  update_user.email = params[:email]
  update_user.password = params[:password]
  if update_user.valid? == false
    @errors = update_user.errors.messages
    return erb :account_update
  elsif update_user.valid? == true
    update_user.save
    @errors = ["Success. Account updated"]
    @type = "success"
    erb :account_update
  end
end


get '/' do
  erb :index
end

get '/upload' do
  origin_path('upload')
  erb :upload
end

# post '/upload' do
#   unless params[:file] &&
#          (tmpfile = params[:file][:tempfile]) &&
#          (name = params[:file][:filename])
#     @error = "No file selected"
#     return haml(:upload)
#   end
#   while blk = tmpfile.read(65536)
#     # TODO File.write to location ??? ASK
#     # TODO Path = new loaction
#   end
#   @path = params[:file][:tempfile].path
#   erb :upload
# end



get '/new' do
  origin_path('new')
  erb :add_new
end

post '/new' do
  @type = "warning"
  @new_song = Song.new
  # for file uploads only
  if session[:origin_path] == 'upload'
    @path = params[:file][:tempfile].path
    mp3_file = File.open(@path, "rb")
    tag = ID3Tag.read(mp3_file)
    @new_song.artist = tag.artist
    @new_song.title = tag.title
    @new_song.album = tag.album
    @new_song.genre = tag.genre
    @new_song.song_type = 'mp3'
    @new_song.song_file = params[:file]
    @new_song.location_url = 'temp'
  end
  if session[:origin_path] != 'upload'
    @new_song.location_url = params[:location_url]
    @new_song.artist = params[:artist]
    @new_song.title = params[:title]
    @new_song.album = params[:album]
    @new_song.genre = params[:genre]
    @new_song.song_type = params[:song_type]
  end

  @new_song.user_id = User.find(current_user.id)
  if @new_song.valid? == false
    @message = @new_song.errors.messages
    # return erb :add_new
  elsif @new_song.valid? == true
    @new_song.user_id = current_user.id
    @new_song.save
    @message = ["Success. Song added."]
    @type = "success"
    user = User.find_by(email: params[:email])
    # erb :add_new
  end
  if session[:origin_path] == 'upload'
    erb :upload
  else
    erb :add_new
  end
end

get '/collection' do
  @collection = Song.where(user_id: current_user.id)
  erb :collection
end

get '/edit/:id' do
  @song = Song.find(params[:id])
  erb :edit_song
end

post '/edit/:id' do
  @song = Song.find(params[:id])
  @song.title = params[:title]
  @song.artist = params[:artist]
  @song.genre = params[:genre]
  @song.album = params[:album]
  @song.location_url = params[:location_url]
  @song.song_type = params[:song_type]
  @song.save
  @type = "success"
  @message = ["Song updated"]
  erb :edit_song
end

post '/song/:id/delete' do
  @song = Song.find_by(id: "#{ params[:id] }")
  @song.destroy
  @type = "warning"
  @message = ["Song deleted"]
  erb :edit_song
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



get '/account' do
  erb :account
end

get '/help' do
  erb :help
end
