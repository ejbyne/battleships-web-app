class BattleShips < Sinatra::Base

  error do
    if invalid_placement
      flash[:notice] = env['sinatra.error'].message
      redirect '/place_ships'
    elsif invalid_shot
      flash[:notice] = env['sinatra.error'].message
      redirect '/game'
    elsif winner
      session[:winner] = true
      redirect '/results'
    end
  end

  def invalid_placement
    env['sinatra.error'].message == 'You cannot place a ship outside of the grid' ||
      env['sinatra.error'].message == 'You cannot place a ship on another ship'
  end

  def invalid_shot
    env['sinatra.error'].message == 'No such coordinate' ||
      env['sinatra.error'].message == 'Already hit'
  end

  def winner
    env['sinatra.error'].message == 'Winner!'
  end

end
