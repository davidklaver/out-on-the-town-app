class ItinerariesController < ApplicationController
#IMPORTANT!!! Where I'm Up To:
# need to save approved itinerary to database for future viewing - see line 204 and latest terminal rollbacks.

	def new		
	end

	def show

		#PSEUDOCODE
		# Goal is to return x number of places to user, in an array

		# price levels: 
		# Yelp's:
		# $= under $10
		# $$= $11-$30
		# $$$= $31-$60
		# $$$$= above $61

		# 0 = free
		# 1= 10
		# 2= 25
		# 3= 50
		# 4= 75

	#Turn params[:area] into latitude and longitude for google places api:
		location = Unirest.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{params[:area]}&key=AIzaSyAHr-fIUrrFZR7yJQcSW9zlUxRBKHO1bRY").body["results"][0]["geometry"]["location"]
		latitude = location["lat"]
		longitude = location["lng"]

		number_of_places = params[:number_of_places].to_i
		if params[:budget] == "no"
			budget = params[:budget]
		else 
			budget = params[:budget].to_i
		end
		# Create an array of fun place types that google accepts:
		google_fun_place_types = ["amusement_park","aquarium","art_gallery","bowling_alley","campground","casino","library","movie_theater","museum","night_club","park","spa","stadium","zoo"]

		@places_array = []
		@total_price_level = 0
		# If include_eatery? is "Yes", then first api request should be for a type=restaurant:
		if params[:include_eatery?] == "Yes"
			if budget == "no"
				eateries = Unirest.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{latitude},#{longitude}&radius=5000&minprice=1&type=restaurant&key=AIzaSyD4dgUSGunP-GIbDCI9DD2p4dm4h6tjN_E").body["results"]
			else
				eateries = Unirest.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{latitude},#{longitude}&radius=5000&maxprice=#{budget + 1 - number_of_places}&type=restaurant&key=AIzaSyD4dgUSGunP-GIbDCI9DD2p4dm4h6tjN_E").body["results"]
				p "THIS IS THE RESULT:"
				p eateries
			end
			eatery = eateries.sample
			#ensure we get an eatery that isn't a lodging:
			while eatery["types"][0] == "lodging"
				eatery = eateries.sample
			end #end while
			eatery_id = eatery["place_id"]
			detailed_eatery = Unirest.get("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{eatery_id}&key=AIzaSyD4dgUSGunP-GIbDCI9DD2p4dm4h6tjN_E").body["result"]
			if detailed_eatery["opening_hours"]
				opening_hours = detailed_eatery["opening_hours"]["weekday_text"]
			else
				opening_hours = ["","","","","","",""]
			end #end if

			@places_array << {
				name: detailed_eatery["name"],
				monday_hours: opening_hours[0],
				tuesday_hours: opening_hours[1],
				wednesday_hours: opening_hours[2],
				thursday_hours: opening_hours[3],
				friday_hours: opening_hours[4],
				saturday_hours: opening_hours[5],
				sunday_hours: opening_hours[6],
				place_id: detailed_eatery["place_id"],
				price_level: detailed_eatery["price_level"],
				rating: detailed_eatery["rating"],
				address: detailed_eatery["formatted_address"],
				phone: detailed_eatery["formatted_phone_number"],
				google_maps_url: detailed_eatery["url"],
				website: detailed_eatery["website"],
				lat: detailed_eatery["geometry"]["location"]["lat"],
				lng: detailed_eatery["geometry"]["location"]["lng"],
				type1: detailed_eatery["types"][0].gsub("_", " "),
				type2: detailed_eatery["types"][1].gsub("_", " ")
			}
			@total_price_level += detailed_eatery["price_level"]
		end #end if for params[:eatery]

		# Add the other places (except the last place, which will depend on how much of the budget is left):
		if budget == "no"
			places_to_get = number_of_places
		else
			places_to_get = number_of_places - 1
		end
		while @places_array.length < places_to_get
			place = nil
			while !place
				place = Unirest.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{latitude},#{longitude}&radius=5000&minprice=0&type=#{google_fun_place_types.sample}&key=AIzaSyD4dgUSGunP-GIbDCI9DD2p4dm4h6tjN_E").body["results"].sample
			end
			#ensure this place is unique to this array, and that we leave room in the budget (if there is one) for the last place:
			if budget == "no"
				while !place || @places_array.any? {|place_hash| place_hash[:name] == place["name"]}
				place = Unirest.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{latitude},#{longitude}&radius=5000&minprice=0&type=#{google_fun_place_types.sample}&key=AIzaSyD4dgUSGunP-GIbDCI9DD2p4dm4h6tjN_E").body["results"].sample
				p "This is the place:"
				p place
				end #end while for uniqueness
			else
				while !place || @places_array.any? {|place_hash| place_hash[:name] == place["name"]} || budget - (place["price_level"] + @total_price_level) < 1
				place = Unirest.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{latitude},#{longitude}&radius=5000&minprice=0&type=#{google_fun_place_types.sample}&key=AIzaSyD4dgUSGunP-GIbDCI9DD2p4dm4h6tjN_E").body["results"].sample
				p "This is the place:"
				p place
				end #end while for uniqueness
			end
			place_id = place["place_id"]
			detailed_place = Unirest.get("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=AIzaSyD4dgUSGunP-GIbDCI9DD2p4dm4h6tjN_E").body["result"]
			p "The detailed_place is:"
			p detailed_place
			if detailed_place["opening_hours"]
				opening_hours = detailed_place["opening_hours"]["weekday_text"]
			else
				opening_hours = ["","","","","","",""]
			end #end if

			@places_array << {
				name: detailed_place["name"],
				monday_hours: opening_hours[0],
				tuesday_hours: opening_hours[1],
				wednesday_hours: opening_hours[2],
				thursday_hours: opening_hours[3],
				friday_hours: opening_hours[4],
				saturday_hours: opening_hours[5],
				sunday_hours: opening_hours[6],
				place_id: detailed_place["place_id"],
				price_level: detailed_place["price_level"],
				rating: detailed_place["rating"],
				address: detailed_place["formatted_address"],
				phone: detailed_place["formatted_phone_number"],
				google_maps_url: detailed_place["url"],
				website: detailed_place["website"],
				lat: detailed_place["geometry"]["location"]["lat"],
				lng: detailed_place["geometry"]["location"]["lng"],
				type1: detailed_place["types"][0].gsub("_", " "),
				type2: detailed_place["types"][1].gsub("_", " ")
			}
			@total_price_level += detailed_place["price_level"]
		end #end while

#Now, for the final place, let's use what's left of the budget:
		p "This is @total_price_level before the last place:"
		p @total_price_level
		if @places_array.length < number_of_places
			place = nil
			while !place
				place = Unirest.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{latitude},#{longitude}&radius=5000&maxprice=#{budget - @total_price_level}&type=#{google_fun_place_types.sample}&key=AIzaSyD4dgUSGunP-GIbDCI9DD2p4dm4h6tjN_E").body["results"].sample
			end
			#ensure this place is unique to this array:
			while !place || @places_array.any? {|place_hash| place_hash[:name] == place["name"]}
				place = Unirest.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{latitude},#{longitude}&radius=5000&maxprice=#{budget - @total_price_level}&type=#{google_fun_place_types.sample}&key=AIzaSyD4dgUSGunP-GIbDCI9DD2p4dm4h6tjN_E").body["results"].sample
				p "This is the place:"
				p place
			end #end while for uniqueness
			place_id = place["place_id"]
			detailed_place = Unirest.get("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=AIzaSyD4dgUSGunP-GIbDCI9DD2p4dm4h6tjN_E").body["result"]
			p "The detailed_place is:"
			p detailed_place
			if detailed_place["opening_hours"]
				opening_hours = detailed_place["opening_hours"]["weekday_text"]
			else
				opening_hours = ["","","","","","",""]
			end #end if

			@places_array << {
				name: detailed_place["name"],
				monday_hours: opening_hours[0],
				tuesday_hours: opening_hours[1],
				wednesday_hours: opening_hours[2],
				thursday_hours: opening_hours[3],
				friday_hours: opening_hours[4],
				saturday_hours: opening_hours[5],
				sunday_hours: opening_hours[6],
				place_id: detailed_place["place_id"],
				price_level: detailed_place["price_level"],
				rating: detailed_place["rating"],
				address: detailed_place["formatted_address"],
				phone: detailed_place["formatted_phone_number"],
				google_maps_url: detailed_place["url"],
				website: detailed_place["website"],
				lat: detailed_place["geometry"]["location"]["lat"],
				lng: detailed_place["geometry"]["location"]["lng"],
				type1: detailed_place["types"][0].gsub("_", " "),
				type2: detailed_place["types"][1].gsub("_", " ")
			}
			@total_price_level += detailed_place["price_level"]
		end
		p "*" * 50
		p "The @total_price_level is:"
		p @total_price_level
		p "and here's the @places_array:"
		p @places_array
		p "*" * 50
		render 'show.html.erb'
	end # end show method
	def create

		itinerary = Itinerary.create(user_id: current_user.id)
		@places_array = []
		params["all_places_hash"].each do |place_key, place|
				itineraried_place = ItinerariedPlace.create!(
			    itinerary_id: itinerary.id,
			    user_id: itinerary.user_id,
					place_id: place["place_id"],
			    name: place["name"],
			    price_level: place["price_level"],
			    rating: place["rating"],
			    address: place["address"],
			    phone: place["phone"],
			    google_maps_url: place["google_maps_url"],
			    website: place["website"],
			    lat: place["lat"],
			    lng: place["lng"],
    			type1: place["type1"],
    			type2: place["type2"],
    			monday_hours: place["monday_hours"],
    			tuesday_hours: place["tuesday_hours"],
    			wednesday_hours: place["wednesday_hours"],
    			thursday_hours: place["thursday_hours"],
    			friday_hours: place["friday_hours"],
    			saturday_hours: place["saturday_hours"],
    			sunday_hours: place["sunday_hours"]
					)
		# @places_array << itineraried_place
		end
		# p @places_array
		# render 'show.html.erb'
		# flash[:success] = "Itinerary Saved!"
	end # end create method
end #end class