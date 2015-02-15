require 'spec_helper'
require_relative '../app/models/ship'

describe Ship do
  
  let (:ship) { Ship.new(3) }

  it 'is not hit when initializied' do
    expect(ship).not_to be_hit
  end

  it 'can be hit' do
    ship.hit!
    expect(ship).to be_hit
  end

  it 'is not sunk unless hit a number of times equal to its length' do
    2.times { ship.hit! }
    expect(ship).not_to be_sunk
  end

  it 'knows when it is sunk' do
    ship.length.times { ship.hit! }
    expect(ship).to be_sunk
  end

  it 'can create an aircraft carrier' do
    aircraft_carrier = Ship.aircraft_carrier
    expect(aircraft_carrier.length).to eq(5)
  end

  it 'can create a battleship' do
    battleship = Ship.battleship
    expect(battleship.length).to eq(4)
  end

  it 'can create a destroyer' do
    destroyer = Ship.destroyer
    expect(destroyer.length).to eq(3)
  end

  it 'can create a submarine' do
    submarine = Ship.submarine
    expect(submarine.length).to eq(3)
  end

  it 'can create a patrol boat' do
    patrol_boat = Ship.patrol_boat
    expect(patrol_boat.length).to eq(2)
  end

end
