class PlacesController < ApplicationController


	def index
		# if params[:area]
			
		# 	# p "*" * 50
			
		# 	# p Unirest.get("https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyDAxVWlsuK2iyl0ZqM9h4To8WdmtverwIQ&new_forward_geocoder=true&address=#{params[:area]}").body["results"]
			
		# 	# p "*" * 50
			
		# 	location = Unirest.get("https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyDAxVWlsuK2iyl0ZqM9h4To8WdmtverwIQ&new_forward_geocoder=true&address=#{params[:area]}").body["results"][0]["geometry"]["location"]
		# 	latitude = location["lat"]
		# 	longitude = location["lng"]

		# 	@places = Unirest.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{latitude},#{longitude}&radius=5000&type=restaurant&key=AIzaSyAIns3enZwqky9L60Pfj1AmlfgIHyL6tUo").body["results"]
		# 	@places.each do |place|
		# 		place_id = place["place_id"]
		# 		if Unirest.get("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=AIzaSyAIns3enZwqky9L60Pfj1AmlfgIHyL6tUo").body["result"]["opening_hours"]

		# 			place["hours"] = Unirest.get("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=AIzaSyAIns3enZwqky9L60Pfj1AmlfgIHyL6tUo").body["result"]["opening_hours"]["weekday_text"]
		# 		end
		# 	end
		# end	
		# render json: Unirest.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&type=restaurant?limit=5&key=AIzaSyAIns3enZwqky9L60Pfj1AmlfgIHyL6tUo").body["results"]
	end


end
