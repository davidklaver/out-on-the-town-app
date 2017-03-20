Rails.application.routes.draw do
	get '/' => 'itineraries#home'

	get '/signup' => 'users#new'
	post '/users' => 'users#create'

	get '/login' => 'sessions#new'
	post '/login' => 'sessions#create'
	get '/logout' => 'sessions#destroy'

	get 'itineraries' => 'itineraries#index'
	get '/itineraries/new' => 'itineraries#new'
	get '/itineraries/suggested_itinerary' => 'itineraries#suggested_itinerary'
	get '/itineraries/no_places' => 'itineraries#no_places'
	get '/itineraries/:id' => 'itineraries#show'
	post '/itineraries' => 'itineraries#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
