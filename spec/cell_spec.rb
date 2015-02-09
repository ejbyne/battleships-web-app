require_relative '../app/models/cell'

describe Cell do

  let (:water) { double :water }
  let (:water_class) { double :water_class, :new => water }
  let (:cell) { Cell.new(water_class) }

  it 'has content' do
    expect(cell.content).to be(water)
  end

  it 'will allow its content to be hit' do
    expect(water).to receive(:hit!)
    cell.hit!
  end

  it 'knows if its content has been hit' do
    expect(water).to receive(:hit?)
    cell.hit?
  end

  it 'knows when it has been shot at' do
    allow(water).to receive(:hit!)
    cell.hit!
    expect(cell).to be_shot_at
  end

  it 'knows if it has not been shot at' do
    expect(cell).not_to be_shot_at
  end

end
