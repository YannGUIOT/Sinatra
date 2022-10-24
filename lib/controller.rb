require 'gossip'
require 'comment'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"],params["gossip_content"]).save
    redirect '/'
  end
  # les infos des formulaires son mémorisé temporairement dans un hash 'params'
  # le hash se vide à chaque nouvelle requete


  # Display Gossip
  get '/gossips/:id' do
    erb :show, locals: {id: params[:id].to_i, gossip: Gossip.find((params[:id].to_i)), comments: Comment.select_by_id((params[:id].to_i))}
  end

  #save new comment
  post '/gossips/:id' do
		Comment.new(params[:id], params["comment_author"], params["comment_content"]).save
    erb :show, locals: {id: params[:id].to_i, gossip: Gossip.all[(params[:id].to_i)], comments: Comment.select_by_id((params[:id].to_i))}
	end


  #permet d'éditer un commentaire
  get '/gossips/:id/edit/' do
    erb :edit, locals: {id: params[:id].to_i, gossip: Gossip.all[(params[:id].to_i)]}
  end

  #sauvegarde et met a jour le fichier csv avec les modifications
  post '/gossips/:id/edit/' do
		Gossip.upgrade(params["gossip_author"], params["gossip_content"], (params[:id].to_i))
		redirect '/'
  end


end