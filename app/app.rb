require 'sinatra/base'
require_relative '../lib/player'
require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/water'
require_relative '../lib/cell'
require_relative '../lib/ship'

class BattleShips < Sinatra::Base

  set :views, Proc.new { File.join(root, "views") }
  
  GAME = Game.new

  get '/' do
    erb :index 
  end

  post '/registration' do
    erb :registration
  end

  post '/place_ships' do
    @board = Board.new
    @player = Player.new
    @player.name = params[:player_name]
    @grid = @board.grid
    @rows = @grid.values.each_slice(10).map{|row| row}
    @player.board = @board
    erb :place_ships
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
