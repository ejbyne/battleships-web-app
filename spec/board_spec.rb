require 'board'

describe Board  do


let(:board)                                {  Board.new                      }
let(:water)                                {  double :water                    }
let(:cell_with_water)                      {  double :cell, content: water    }
let(:ship)                                {  double :ship, length: 2          }
let(:cell_with_ship)                      {  double :cell, content: ship      }
let(:cell_hit)                            {  double :cell, :hit? => true      }
let(:cell_no_hit)                          {  double :cell, :hit? => false    }


def initialize_grid
board.rows
board.columns
board.setting_coordinates
end

it 'has a grid of 100 cells' do
board.gridded
expect(board.grid.size).to be(100)
end

it 'should have coordinates' do
expect(board.grid[:A1]).to be_an_instance_of(Cell)
end

context 'placing ships' do

it 'knows which one will be the next horizontal coordinate' do
orientation = 'horizontal'
coord = 'A1'
initialize_grid
expect(board.grid.size).to be(100)
expect(board.next_coord(coord, orientation)).to eq('A2')
end

it 'knows which one will be the next vertical coordinate' do
orientation = 'vertical'
coord = 'A1'
initialize_grid
expect(board.grid.size).to be(100)
expect(board.next_coord(coord, orientation)).to eq('B1')
end

it 'does allow the player to place the ships inside the board' do
initialize_grid
expect(board.grid.size).to be(100)
expect(board.coord_in_grid('A2')).to be true
end

it 'does not allow the player to place the ship outside the board' do
initialize_grid
expect(board.grid.size).to be(100)
expect(board.coord_in_grid('A12')).to be false
end

it 'can place the ship horizontally' do
initialize_grid
expect(board.grid.size).to be(100)
orientation = 'horizontal'
expect(board.place(ship, 'A1', orientation)).to eq(["A1", "A2"])
end

it 'can place the ship vertically' do
initialize_grid
expect(board.grid.size).to be(100)
orientation = 'vertical'
expect(board.place(ship, 'B1', orientation)).to eq(["B1", "C1"])
end


end

# context 'after a shoot' do


# it "passes a shot onto a ship" do
# expect(board.shoot('A1')).to be true
# end


	
# end













#  table2 = Terminal::Table.new do |t|
#       t << ['A', '~']
# 			t.add_row ['B', '~']
# 	 end


# letters = [*'A'..'J']





# puth










