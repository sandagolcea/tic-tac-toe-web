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
    coordinates = params[:coord]
    @board = session[:board]
    @player1 = session[:player1]
    @player2 = session[:player2]

    session[:board].set(coordinates,session[:current_player])

    if session[:board].game_over?(coordinates,session[:current_player]) || session[:board].full?
      redirect '/endgame'
    else  
      session[:current_player] = session[:current_player] == session[:player1] ? session[:player2] : session[:player1]
      @current_player = session[:current_player]

      erb :game
    end

  end

  get '/endgame' do
      @current_player = session[:current_player]

      if session[:board].full?
        @result = "It's a draw!"
      else
        @result = @current_player
      end
    erb :endgame
  end

  
    # stop when board is full
    # stop when game is over
    # redirect to showing winner or draw when game is over
    
  
  # start the server if ruby file executed directly
  run! if app_file == $0
end
