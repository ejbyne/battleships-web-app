class Game

  attr_reader :attacker, :opponent

  def players
    @players ||= []
  end

  def add_player(player)
    raise "The game already has two players" if players.count >= 2
  	self.players << player
	end

  def attacker
    players[0]
  end

  def opponent
    players[1]
  end

  def has_players?
    players.count == 2
  end

  def has_boards?
    attacker.board and opponent.board
  end

  def has_ships?
    attacker.board.ship_count == 5 and opponent.board.ship_count == 5
  end

  def ready?
    has_players? and has_boards? and has_ships?
  end

  def switch_turn
    players.rotate!
  end

  def whose_turn
    attacker
  end

  def fire_at(coordinates)
    raise "not ready to play" unless ready?
    opponent.receive_shot(coordinates)
    raise "Winner!" if won?
    switch_turn
  end

  def won?
    opponent.board.sunk?
  end

end
