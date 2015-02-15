class BattleShips < Sinatra::Base

  def fire_shot
    GAME.fire_at(params[:column] + params[:row])
    record_hit
  end

  def record_hit
    if other_player.board.grid[(params[:column] + params[:row]).to_sym].content.is_a?(Ship)
      session[:hit?] = true
    else
      session[:hit?] = false
    end
  end

end
