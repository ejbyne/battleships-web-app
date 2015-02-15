require 'spec_helper'
require_relative '../app/models/player'

describe Player do

  let (:player) { Player.new }
  let (:board) { double :board }

  it 'should initialize without a board' do
    expect(player.board?).to be false
  end

  it 'should know if it has a board' do
    player.board = board
    expect(player.board?).to be true
  end

  it 'should shoot at the board' do
    player.board = board
    expect(board).to receive(:shoot).with(:A1)
    player.receive_shot(:A1)
  end

end
