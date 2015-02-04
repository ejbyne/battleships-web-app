require 'board'

describe Board do

	let(:ship) { double :ship, length: 3, sunk?: false }
	let(:cell) { double :cell, content: water, shot_at?: false }
	let(:water) { double :water }
	let(:cell_class) { double :cell_class, :new => cell }
	let(:board) { Board.new(cell_class) }
	
	context 'creating the grid' do

		it 'has a grid of 100 coordinates' do
			expect(board.grid.size).to be(100)
		end

		it 'should have coordinates ranging from A1 to J10' do
			expect(board.grid.keys.first).to eq(:A1)
			expect(board.grid.keys.last).to eq(:J10)
		end

		it 'should have a cell object as the value of each coordinate' do
			board.grid.values.each do |value|
				expect(value).to eq(cell)
			end
		end

	end

	context 'placing ships' do

		it 'enables a ship to be placed horizontally' do
			expect(board.grid[:A1]).to receive(:content=).with(ship)
			expect(board.grid[:B1]).to receive(:content=).with(ship)
			expect(board.grid[:C1]).to receive(:content=).with(ship)
			board.place(ship, 'A1', 'horizontal')
		end

		it 'enables a ship to be placed vertically' do
			expect(board.grid[:A1]).to receive(:content=).with(ship)
			expect(board.grid[:A2]).to receive(:content=).with(ship)
			expect(board.grid[:A3]).to receive(:content=).with(ship)
			board.place(ship, 'A1', 'vertical')
		end

		it 'will not allow a ship to be placed outside the grid' do
			expect { board.place(ship, 'J1', 'horizontal') }.to raise_error('You cannot place a ship outside of the grid')
		end

		it 'will not allow a ship to be placed over an existing ship' do
			allow(board.grid[:A1]).to receive(:content).and_return(ship)
			allow(board.grid[:B1]).to receive(:content).and_return(ship)
			allow(board.grid[:C1]).to receive(:content).and_return(ship)
			expect { board.place(ship, 'A1', 'horizontal') }.to raise_error('You cannot place a ship on another ship')
		end

	end

	context 'shooting at coords' do

		it 'will allow a coordinate to be shot' do
			expect(board.grid[:A1]).to receive(:hit!)
			board.shoot('A1')
		end

		it 'will not allow a non-existent coordinate to be shot' do
			expect { board.shoot('K1') }.to raise_error('No such coordinate')
		end

		it 'will not allow a coordinate to be shot at more than once' do
			allow(board.grid[:A1]).to receive(:shot_at?).and_return(true)
			expect { board.shoot('A1') }.to raise_error('Already hit')
		end

	end

	context 'sinking ships' do

		before do
			allow(board.grid[:A1]).to receive(:content).and_return(ship)
			allow(board.grid[:B1]).to receive(:content).and_return(ship)
			allow(board.grid[:C1]).to receive(:content).and_return(ship)
		end

		it 'knows how many ships there are' do
			expect(board.ship_count).to eq(1)
		end

		it 'knows when the ships have not been sunk' do
			expect(board.all_ships_sunk?).to be(false)
		end

		it 'knows when the ships have been sunk' do
			allow(ship).to receive(:sunk?).and_return(true)
			expect(board.all_ships_sunk?).to be(true)
		end

	end

end
