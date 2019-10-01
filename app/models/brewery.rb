class Brewery < ActiveRecord::Base
    has_many :bookmarks
    has_many :users, through: :bookmarks

    def find_breweries_match_users_areacode(user_area_code)
        Brewery.all.select do |brew|
            brew.phone_number[0,3] == user_area_code
        end
    end

    def brewery_by_city_and_type(city, type)
        Brewery.all.select do |brew|
            brew.city == city && brew.brewery_type == type
        end
    end
end