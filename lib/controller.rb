require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"],params["gossip_content"]).save
    redirect '/'
  end
  # les infos des formulaires son mémorisé temporairement dans un hash 'params'
  # le hash se vide à chaque nouvelle requete
end