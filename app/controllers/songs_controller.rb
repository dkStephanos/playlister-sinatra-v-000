require 'pry'
require 'rack-flash'

class SongsController < ApplicationController

  enable :sessions
  use Rack::Flash

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])

    erb :'songs/edit'
  end

  post '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.artist = Artist.create_or_find_by(name: params[:song]["artist_name"])
    @song.genre_ids = params[:song]["genre_ids"]
    @song.save

    flash[:message] = "Successfully updated song."

    redirect to "songs/#{@song.slug}"
  end

  get '/songs/new' do

  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])

    erb :'songs/show'
  end

  get '/songs' do
    LibraryParser.parse
    erb :'songs/index'
  end
end
