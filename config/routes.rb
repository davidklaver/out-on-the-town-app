Rails.application.routes.draw do
	get '/' => 'places#index'

	get '/signup' => 'users#new'
	post '/users' => 'users#create'

	get '/login' => 'sessions#new'
	post '/login' => 'sessions#create'
	get '/logout' => 'sessions#destroy'

	get '/itineraries/new' => 'itineraries#new'
	get '/itineraries/suggested_itinerary' => 'itineraries#show'
	post '/itineraries' => 'itineraries#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
