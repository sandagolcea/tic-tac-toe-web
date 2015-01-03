require 'sinatra/base'
require_relative 'player'
require_relative 'board'

class TicTacToe < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/fight' do
     first = params[:firstplayer]
     second = params[:secondplayer]
    
    @player1 = Player.new(first,"X")
    @player2 = Player.new(second,"0")
    "Hello #{@player1.name} and #{@player2.name}"

    @board = Board.new
    erb :fight
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
