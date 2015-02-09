class Ship

  attr_reader :length

  def initialize(length)
    @length = length
    @hit = false
    @number_of_hits = 0
  end

  def hit?
    @hit
  end

  def hit!
    @hit = true
    @number_of_hits += 1
  end

  def sunk?
    @number_of_hits == @length
  end

  def self.aircraft_carrier
    new 5
  end

  def self.battleship
    new 4
  end

  def self.destroyer
    new 3
  end

  def self.patrol_boat
    new 2
  end

  def self.submarine
    new 3
  end

end
