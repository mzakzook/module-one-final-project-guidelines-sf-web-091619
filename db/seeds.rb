
get_brewery_info_from_api.each do |brew|
    Brewery.find_or_create_by(name: brew["name"].downcase, brewery_type: brew["brewery_type"], city: brew["city"].downcase, phone_number: brew["phone"])
end

city_array = ["Oakland", "Los Angeles", "San Francisco", "San Diego", "Sacramento", "Hollister"]
area_codes = ["310", "510", "415", "831", "213", "619", "916"]

1000.times do
    User.create(name: Faker::Name.name, city: city_array.sample, phone_number: area_codes.sample + Faker::PhoneNumber.subscriber_number(length: 7))
end

beers = ["IPA", "Pale Ale", "Cider", "Stout", "Porter", "Sour", "Kombucha", "Brown Ale", "Pilsner", "Bock", "Lager"]

5000.times do 
    Bookmark.create(brewery_id: Brewery.all.sample[:id], user_id: User.all.sample[:id], rating: rand(1..5), favorite: beers.sample)
end