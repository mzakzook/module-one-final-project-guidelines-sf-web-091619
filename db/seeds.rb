city_array = ["Oakland", "Los Angeles", "San Francisco", "San Diego", "Sacramento", "Hollister"]
area_codes = ["310", "510", "415", "831", "213", "619", "916"]

60.times do
    User.create(name: Faker::Name.name, city: city_array.sample, phone_number: area_codes.sample + Faker::PhoneNumber.subscriber_number(length: 7))
end