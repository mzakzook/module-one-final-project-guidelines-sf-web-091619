class User < ActiveRecord::Base
    has_many :bookmarks
    has_many :breweries, through: :bookmarks

    def user_area_code
        self.phone_number[0,3]
    end

    def user_fav_drink
        my_bookmarks = Bookmark.all.select {|bm| bm.user == self}
        my_bookmarks.max_by {|mbm| mbm.favorite_drink}.favorite_drink
    end

end