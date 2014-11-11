require 'sinatra/base'

class BattleShips < Sinatra::Base
  get '/' do
    'Welcome to Battle Ships!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
