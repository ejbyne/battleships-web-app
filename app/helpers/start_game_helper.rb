class BattleShips < Sinatra::Base

  def create_player_and_board
    player = Player.new
    board = Board.new(Cell, Water)
    player.name = params[:player_name]
    player.board = board
    GAME.add_player(player)
    session[:me] = player.object_id
  end

  def player
    GAME.select_player_by_id(session[:me])
  end

  def other_player
    other_player = GAME.select_other_player_by_id(session[:me])
  end

end
