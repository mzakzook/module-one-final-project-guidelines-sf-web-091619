class User < ActiveRecord::Base
    has_many :bookmarks
    has_many :breweries, through: :bookmarks

    # def user_area_code(user_id)
    #     x  = User.select('phone_number').where('id = ?', user_id).phone_number
    #     x[0].phone_number[0...3]
    # end

    def user_fav_drink
       if self.bookmarks.count > 0
            fav_drink = Bookmark.select('favorite, count(favorite) as cnt').where('user_id = ?', self.id).group('favorite').order('cnt DESC').first
            puts "Your favorite drink is a(n) #{fav_drink.favorite}, with #{fav_drink.cnt} bookmark(s)!"
            fav_drink.favorite
       else
            puts "You do not have any bookmarks."
       end
    end

end