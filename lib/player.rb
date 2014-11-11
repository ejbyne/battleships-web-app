class Player

  attr_accessor :board

  def board
    !@board.nil?
  end

  def receive_shot(coordinates)
    @board.shoot(coordinates)
  end

end