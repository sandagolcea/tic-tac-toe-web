require 'sinatra/base'
require_relative 'player'
require_relative 'board'

class TicTacToe < Sinatra::Base
  enable :sessions

  get '/' do
    erb :index
  end

  post '/game' do
     first = params[:firstplayer]
     second = params[:secondplayer]
      
    @player1 = Player.new(first,"X")
    @player2 = Player.new(second,"0")
    "Hello #{@player1.name} and #{@player2.name}"
    
    @current_player = [@player1,@player2].sample

    @board = Board.new

    session[:player1] = @player1
    session[:player2] = @player2
    session[:current_player] = @current_player
    session[:board] = @board

    erb :game
  end

  post '/game/move' do
    'Hola bola'
    session[:player1].name
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end
