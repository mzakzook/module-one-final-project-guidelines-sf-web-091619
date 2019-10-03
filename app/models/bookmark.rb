class Bookmark < ActiveRecord::Base
    belongs_to :user
    belongs_to :brewery

    def self.most_bookmarked_brewery
        # brewery_ids = Bookmark.all.map {|bookmark| bookmark.brewery_id }
        # fav_brew_id = brewery_ids.max_by {|id| brewery_ids.count(id)}
        # Brewery.all.find_by(id: fav_brew_id)
        most_brew = Bookmark.select('id, brewery_id, count(brewery_id) as cnt').group('brewery_id').order('cnt DESC').first
        puts "#{most_brew.brewery.name}, in #{most_brew.brewery.city}, CA, has the most bookmarks with #{most_brew.cnt} bookmarks."
    end

    def self.best_brewery
        # our_brews = Bookmark.all.map { |bm| bm.brewery }.uniq
        #our_brews.max_by {|brew| brew.brewery_rating}
        best_brew = Bookmark.select('id, brewery_id, AVG(rating) as average_rating').group('brewery_id').order('average_rating DESC').first
        puts "#{best_brew.brewery.name}, in #{best_brew.brewery.city}, CA, is our fans' favorite with a score of #{best_brew.average_rating}."
        best_brew.brewery.name
    end
end

#Bookmark.select('id, brewery_id, AVG(rating) as avg_rating').group('brewery_id').order('avg_rating DESC')

# Brewery.select('breweries.id, AVG(bookmarks.rating) as average_rating').joins(:bookmarks).group('breweries.id').order('average_rating DESC')

# SELECT bookmarks.brewery_id, AVG(bookmarks.rating) 
# FROM bookmarks
# GROUP BY bookmarks.brewery_id
# ORDER BY AVG(bookmarks.rating) DESC
# LIMIT 1
