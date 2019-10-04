class Brewery < ActiveRecord::Base
    has_many :bookmarks
    has_many :users, through: :bookmarks

    def self.find_breweries_match_users_areacode(user_area_code)
    #     Brewery.all.select do |brew|
    #         brew.phone_number[0,3] == user_area_code
    #     end
        matched_brews = Brewery.where("phone_number LIKE ?", "#{user_area_code}%")
        if matched_brews.count > 0
            puts "Here's a list of Breweries in your area:\n\n"
            matched_brews.map do |mtchbrw|
                puts "#{mtchbrw.name.split.map(&:capitalize).join(' ')}, phone: #{mtchbrw.phone_number}"
            end
        else
            puts "Your neck of the woods is pretty dry."
        end
    end

  
    def self.brewery_by_city_and_type(city, type)
        # Brewery.all.select do |brew|
        #     brew.city == city && brew.brewery_type == type
        # end
        Brewery.where("city = ? AND brewery_type = ?", city, type)
    end

    # def self.by_city(city)
    #     where(:city => city)
    # end

    # def self.by_type(type)
    #     where(:brewery_type => type)
    # end


    #helper method
    # def brewery_rating
    #     total = self.bookmarks.sum {|bm| bm.rating} 
    #     total / self.bookmarks.count.to_f
    # end
end