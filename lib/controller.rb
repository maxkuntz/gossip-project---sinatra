require 'gossip'

class ApplicationController < Sinatra::Base
  #route INDEX
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  #route GET-NEW
  get '/gossips/new/' do
    erb :new_gossip
  end

  #route POST-NEW
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  #route dynamique GET-SHOW qui affiche le gossip selectionné via la fonction find (ex http://localhost:4567/gossips/1/)
  get '/gossips/:id/' do
    erb :show, locals: {gossip: Gossip.find(params['id'])}
  end

  #route dynamique GET-EDIT
  get '/gossips/:id/edit' do
		erb :edit, locals: {gossip: Gossip.all[params[:id].to_i], id: params[:id].to_i}
	end
	#traitement des données du formulaire edit
  post '/gossips/:id/edit' do
    Gossip.update(params["id"].to_i,params["gossip_author"],params["gossip_content"])
    redirect '/'
  end

end