require 'board'

describe Board do

	let(:board) 	{ Board.new }
	let(:ship)    { double :ship, length: 3, sunk?: false }
	
	context 'creating the grid' do

		it 'has a grid of 100 coordinates' do
			expect(board.grid.size).to be(100)
		end

		it 'should have coordinates ranging from A1 to J10' do
			expect(board.grid.keys.first).to eq(:A1)
			expect(board.grid.keys.last).to eq(:J10)
		end

		it 'should have a cell object as the value of each coordinate' do
			board.grid.values.each do |cell|
				expect(cell).to be_an_instance_of(Cell)
			end
		end

	end

	context 'placing ships' do

		it 'enables a ship to be placed horizontally' do
			board.place(ship, 'A1', 'horizontal')
			expect(board.grid[:A1].content).to eq(ship)
			expect(board.grid[:B1].content).to eq(ship)
			expect(board.grid[:C1].content).to eq(ship)
		end

		it 'enables a ship to be placed vertically' do
			board.place(ship, 'A1', 'vertical')
			expect(board.grid[:A1].content).to eq(ship)
			expect(board.grid[:A2].content).to eq(ship)
			expect(board.grid[:A3].content).to eq(ship)
		end

		it 'will not allow a ship to be placed outside the grid' do
			expect { board.place(ship, 'J1', 'horizontal') }.to raise_error('You cannot place a ship outside of the grid')
		end

		it 'will not allow a ship to be placed over an existing ship' do
			board.place(ship, 'A1', 'horizontal')
			expect { board.place(ship, 'A1', 'horizontal') }.to raise_error('You cannot place a ship on another ship')
		end

	end

	context 'shooting at coords' do



	end

end
