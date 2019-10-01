
get_brewery_info_from_api.each do |brew|
    Brewery.create(name: brew["name"], brewery_type: brew["brewery_type"], city: brew["city"], phone_number: brew["phone"])
end