require 'game'

describe Game do

  let(:game)    { Game.new }
  let(:player1) { double :player, board: board, board?: true, object_id: 1 }
  let(:player2) { double :player, board: board2, board?: true, object_id: 2 }
  let(:board)   { double :board, ship_count: 5 }
  let(:board2)  { double :board, ship_count: 5 }

  context 'Adding players' do

    it 'starts without players' do
      expect(game.players.count).to eq(0)
    end

    it 'can have just one player' do
      game.add_player(player1)
      expect(game.players.count).to eq(1)
    end

    it 'can have two players' do
      game.add_player(player1)
      game.add_player(player2)
      expect(game.players.count).to eq(2)
    end

    it 'cannot be played with more than two players' do
      player3 = double("player")
      game.add_player(player1)
      game.add_player(player2)
      expect { game.add_player(player3) }.to raise_error('The game already has two players') if game.players.count >= 2
    end

  end

  context 'Identifying players by id' do

    before do
      game.add_player(player1)
      game.add_player(player2)
    end

    it 'can identify the player by id' do
      expect(game.select_player_by_id(1)).to eq(player1)
    end

    it 'can identify the other player by id' do
      expect(game.select_other_player_by_id(1)).to eq(player2)
    end

  end

  context 'Taking turns' do

    before do
      game.add_player(player1)
      game.add_player(player2)
    end

    it 'gives 1st player the 1st turn' do
      expect(game.whose_turn).to be(player1)
    end

    it 'switches turns' do
      game.switch_turn
      expect(game.whose_turn).to be(player2)
    end

    it 'switches turns after a player fires' do
      allow(player2).to receive(:receive_shot)
      allow(board2).to receive(:all_ships_sunk?).and_return false
      game.fire_at(:A1)
      expect(game.whose_turn).to be(player2)
    end

    it 'knows when a players wins' do
      allow(board2).to receive(:all_ships_sunk?).and_return true
      expect(game).to be_won
    end

    it 'raises exception if the game is won' do
      allow(player2).to receive(:receive_shot)
      allow(board2).to receive(:all_ships_sunk?).and_return true
      expect { game.fire_at(:F6) }.to raise_error('Winner!')
    end

  end

  context 'Game ready?' do

    before do
      game.add_player(player1)
      game.add_player(player2)
    end

    it 'receives a shot' do
      expect(player2).to receive(:receive_shot)
      allow(board2).to receive(:all_ships_sunk?).and_return false
      game.fire_at(:B1)
    end

    it 'knows that there are two players' do
      expect(game).to have_players
    end

    it 'knows if the players have boards' do
      expect(game).to have_boards
    end

    it 'knows if the players have ships' do
      expect(game).to have_ships
    end

    it 'knows if the game is ready' do
      expect(game).to be_ready
    end

    it 'knows if the game is not ready' do
      allow(board2).to receive(:ship_count).and_return(3)
      expect(game).not_to be_ready
    end

    it 'will not allow a player to fire unless the game is ready' do
      allow(board2).to receive(:ship_count).and_return(3)
      expect{ game.fire_at(:C4) }.to raise_error('Not ready to play')
    end

  end

end
