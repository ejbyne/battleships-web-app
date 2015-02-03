require 'water'

describe Water do

  let(:water) { Water.new }

  it 'is not hit when initialized' do
    expect(water).not_to be_hit
  end

  it 'can be hit' do
  	water.hit!
    expect(water).to be_hit
  end
  
end
