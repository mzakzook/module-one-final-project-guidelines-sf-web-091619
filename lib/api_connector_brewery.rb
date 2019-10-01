require 'rest-client'
require 'json'
require 'pry'



def get_brewery_info_from_api
  #make the web request
  brewery_info = []
  i = 1
  19.times do 
    response_string = RestClient.get("https://api.openbrewerydb.org/breweries?by_state=california&per_page=50&page=#{i}")
    response_hash = JSON.parse(response_string)
    brewery_info << response_hash
    i += 1
  end
  brewery_info.flatten
  binding.pry
end