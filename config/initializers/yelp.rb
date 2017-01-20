# require 'yelp'

# Yelp.client.configure do |config|
#   config.consumer_key = "5DqH9lcDVKosKAiVek6Zng"
#   config.consumer_secret = "UsZDiZ3aczZXcQ-rR69zMTtbVG4"
#   config.token = "9ujnLq6Tbfrht3c169SHWgZoV0pwWX3n"
#   config.token_secret = "7_ifYH5UM0pBP35WXlH1aS26ib8"
# end

# require 'rubygems'
# require 'oauth'

# CONSUMER_KEY = "5DqH9lcDVKosKAiVek6Zng"
# SECRET = "UsZDiZ3aczZXcQ-rR69zMTtbVG4"
# TOKEN = "9ujnLq6Tbfrht3c169SHWgZoV0pwWX3n"
# TOKEN_SECRET = "7_ifYH5UM0pBP35WXlH1aS26ib8"


# consumer = OAuth::Consumer.new( CONSUMER_KEY,SECRET, {:site => "http://api.yelp.com", :signature_method => "HMAC-SHA1", :scheme => :query_string})

# access_token = OAuth::AccessToken.new( consumer, TOKEN,TOKEN_SECRET)

# p access_token.get("/v2/search?location=new+york").body
