require 'yaml/store'
require 'sinatra'
get '/' do
  @title = "Olá Viking!"
  erb :index
end

Choices = {
'1' => 'Kart',
'2' => 'Paintball',
'3' => 'Rafting',
'4' => 'Churras na casa do Vicente com Piscina e Praia',
}

post '/cast' do
  @title = "Obrigada por votar! ;) "
  @vote = params['vote']
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes']}
  erb :results
end
