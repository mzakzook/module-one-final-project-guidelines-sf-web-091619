def wheres_beer
    cgi
    puts "WHERE'S BEER?... in CA"
    puts "          .~~~~."
    puts "          i====i_"
    puts "          |cccc|_)"
    puts "          |cccc|"
    puts "          `-==-'"
    puts " "
    puts "Image courtesy of Hayley Jane Wakenshaw"
    sleep 2
end

def welcome
    cgi
    puts "Hello, beer friend!"
    sleep 1.25
    puts "Would you like to create an account or login?"
    puts "Enter 1 to create account. Enter 2 to login using your id."
    cgi
    user_input = gets.chomp
    create_or_login(user_input)
end

def create_or_login(value)
    if value == "1"
        puts "Please enter your name."
        name = gets.chomp
        puts "Please enter your current city."
        city = gets.chomp
        puts "Please enter your phone number."
        phone_number = gets.chomp
        if phone_number.to_i.to_s == phone_number && phone_number.length == 10
            new_user = User.create(name: name, city: city, phone_number: phone_number)
            cgi
            puts "Your user id is #{new_user.id}. Remember your user id to login in the future!"
            sleep 2
            return new_user
        else 
            cgi
            puts "Please enter valid 10-digit phone number (no extra character, just numbers!)"
            create_or_login("1")
        end
    elsif value == "2"
        cgi
        puts "Please enter your user id."
        user_id = gets.chomp.to_i
        saved_user = User.find_by(id: user_id)
        if saved_user
            cgi
            puts "Welcome back #{saved_user.name}. Happy drinking!"
            sleep 1.5
            return saved_user
        else 
            invalid_input
            welcome
        end
    else
        invalid_input
        welcome
    end
end

def pick_option(user)
    cgi
    puts "What brings you here today?"
    puts "Would you like to: (Enter corresponding number)
    \n 1. Find Brewery
    \n 2. Add Bookmark
    \n 3. Update Profile
    \n 4. Other
    \n 5. Log Out"
    user_input = gets.chomp
    if user_input == "1" 
        find_chosen(user)
    elsif user_input == "2"
        bookmark_chosen(user)
    elsif user_input == "3"
        update_chosen(user)
    elsif user_input == "4"
        other_chosen(user)
    elsif user_input == "5"
        # user = welcome
        # pick_option(user)
        return
    else
        cgi
        invalid_input
        pick_option(user)
    end 
end


def find_chosen(user)
    cgi
    puts "How would you like to search? (Enter corresponding number)
    \n 1. Find Brewery by Name
    \n 2. Find Breweries in your City
    \n 3. Find Breweries with your Area Code
    \n 4. Find Breweries by City & Brewery Type
    \n 5. Find Brewery by their Phone Number"
    cgi
    user_input = gets.chomp
    if user_input == "5" 
        puts "Please enter 10 digit phone number without extra characters (ex: 0000000000)"
        brew_phone_number = gets.chomp
        if brew_phone_number.to_i.to_s == brew_phone_number && brew_phone_number.length == 10 
            brewery = Brewery.find_by(phone_number: brew_phone_number)
            if brewery
                cgi
                puts "Brewery found! #{capital_first(brewery.name)} in #{capital_first(brewery.city)}, CA. Phone number: #{brewery.phone_number}"            
                cgi
                pick_option(user)
            else 
                cgi
                puts "No results found"
                cgi
                find_chosen(user)
            end
        else
            cgi
            puts "Please enter a valid phone number"
            cgi
            find_chosen(user)
        end
    elsif user_input == "3"
        Brewery.find_breweries_match_users_areacode(user.phone_number[0...3])
        pick_option(user)
    elsif user_input == "4" 
        puts "Please enter the city"
        city = gets.chomp
        cgi
        puts "Please enter a brewery type"
        puts "Please select from these options: 
        \n Brewpub, Micro, Planning, Regional, Proprietor, Contract, Large"
        brewery_type = gets.chomp
        cgi
        brewery = Brewery.brewery_by_city_and_type(city.downcase, brewery_type.downcase)
        if brewery.count > 0 
            puts "Here's a list of #{capital_first(brewery_type)} Breweries in #{capital_first(city)}:\n\n"
            cgi
            brewery.map do |brwy|
                if brwy.phone_number.length == 10
                    puts "#{capital_first(brwy.name)}, phone: #{brwy.phone_number}"
                else
                    puts "#{capital_first(brwy.name)}, phone: N/A"
                end
            end
            pick_option(user)
        else 
            invalid_input
            find_chosen(user)
        end
    elsif user_input == "1"
        puts "Please enter Brewery's name"
        name = gets.chomp
        cgi
        brewery = Brewery.where("name like ?", "%#{name.downcase}%")
        if brewery.count > 0
            if brewery.count == 1
                puts "Brewery found! Here is their info:"
                cgi
                if brewery[0].phone_number.length == 10
                    puts "#{capital_first(brewery[0].name)} is located in #{capital_first(brewery[0].city)}, CA. Their phone number is: #{brewery[0].phone_number}"
                else
                    puts "#{capital_first(brewery[0].name)} is located in #{capital_first(brewery[0].city)}, CA."
                end
            else
                puts "Multiple results found. Please select the corresponding number for the brewery you are searching for."
                cgi
                brewery.length.times do |i|
                    puts "#{i + 1}. #{capital_first(brewery[i].name)},   city: #{capital_first(brewery[i].city)}"
                end
                user_input = gets.chomp
                cgi
                if user_input.to_i.to_s == user_input && user_input.to_i.between?(1, brewery.length)
                    if brewery[0].phone_number.length == 10
                        puts "#{capital_first(brewery[user_input.to_i - 1].name)} is located in #{capital_first(brewery[user_input.to_i - 1].city)}, CA. Their phone number is: #{brewery[user_input.to_i - 1].phone_number}"
                    else
                        puts "#{capital_first(brewery[user_input.to_i - 1].name)} is located in #{capital_first(brewery[user_input.to_i - 1].city)}, CA."
                    end
                else
                    invalid_input
                    find_chosen(user)
                end
            end
            pick_option(user)
        else
            invalid_input
            find_chosen(user)
        end
    elsif user_input == '2'
        city_brews = Brewery.select('id, name, phone_number').where('city = ?', User.find_by(id: user.id).city.downcase)
        if city_brews.length > 0
            puts "Breweries found!"
            cgi
            city_brews.each do |cb|
                if cb.phone_number.length == 10
                    puts "#{capital_first(cb.name)}, phone number: #{cb.phone_number}"
                else
                    puts "#{capital_first(cb.name)}"
                end
            end
            pick_option(user)
        else
            invalid_input
            find_chosen(user)
        end
    else 
        invalid_input
        find_chosen(user)
    end
end

def bookmark_chosen(user)
    cgi
    puts "Would you like to Bookmark using the Brewery's name or phone number?
    \n Enter 1 for name & 2 for phone number"
    bm_identifier = gets.chomp
    cgi
    if bm_identifier == "1"
        puts "Please enter Brewery's name"
        name = gets.chomp
        cgi
        brewery = Brewery.where("name like ?", "%#{name.downcase}%")
        
        if brewery.count > 0
            if brewery.count == 1
                puts "Brewery found! Please tell us a little more to save your bookmark...
                \n Rate the Brewery (1-5)"
                rating = gets.chomp
                cgi
                puts "What was your favorite drink?"
                favorite = gets.chomp
                cgi
                Bookmark.create(brewery_id: brewery[0].id, user_id: user.id, rating: rating, favorite: favorite)
                puts "Bookmark saved!"
                pick_option(user)
            else
                puts "Multiple results found. Please select the corresponding number for the brewery you want to bookmark."
                cgi
                brewery.length.times do |i|
                    puts "#{i + 1}. #{capital_first(brewery[i].name)},   city: #{capital_first(brewery[i].city)}"
                end
                user_input = gets.chomp
                cgi
                if user_input.to_i.to_s == user_input && user_input.to_i.between?(1, brewery.length)
                    puts "You've selected #{capital_first(brewery[user_input.to_i - 1].name)} in #{capital_first(brewery[user_input.to_i - 1].city)}! Please tell us a little more to save your bookmark...
                    \n Rate the Brewery (1-5)"
                    rating = gets.chomp
                    cgi
                    puts "What was your favorite drink?"
                    favorite = gets.chomp
                    cgi
                    Bookmark.create(brewery_id: brewery[user_input.to_i - 1].id, user_id: user.id, rating: rating, favorite: favorite)
                    puts "Bookmark saved!"
                    pick_option(user)
                else
                    invalid_input
                    find_chosen(user)
                end
            end
            pick_option(user)
        else
            invalid_input
            find_chosen(user)
        end
    elsif bm_identifier == "2"
        cgi
        puts "Please enter Brewery's phone number"
        phone_number = gets.chomp
        cgi
        brewery = Brewery.find_by(phone_number: phone_number)
        if brewery
            puts "Brewery found! Please tell us a little more to save your bookmark...
            \n Rate the Brewery (1-5)"
            rating = gets.chomp
            cgi
            puts "What was your favorite drink?"
            favorite = gets.chomp
            cgi
            Bookmark.create(brewery_id: brewery.id, user_id: user.id, rating: rating, favorite: favorite)
            puts "Bookmark saved!"
            pick_option(user)
        else 
            invalid_input
            bookmark_chosen(user)
        end
    else
        invalid_input
        bookmark_chosen(user)
    end
end

def update_chosen(user)
    cgi
    puts "What would you like to update?"
    puts "Please choose the corresponding number:
    \n 1. name
    \n 2. phone_number
    \n 3. current city"
    user_input = gets.chomp
    cgi
    if user_input == "1"
        puts "Please input your new name."
        new_name = gets.chomp
        cgi
        x = User.update(user.id, name: new_name)
        puts "Your name has been updated to #{new_name}"
        pick_option(user)
    elsif user_input == "2"
        puts "Please input your new phone number."
        new_number = gets.chomp
        cgi
        User.update(user.id, phone_number: new_number)
        puts "Your phone number has been updated to #{new_number}"
        pick_option(user)
    elsif user_input == "3"
        puts "Please input your new city."
        new_city = gets.chomp
        cgi
        User.update(user.id, city: new_city)
        puts "Your city has been updated to #{new_city}"
        pick_option(user)
    else
        invalid_input
        update_chosen(user)
    end
end

def other_chosen(user)
    cgi
    puts "Would you like to: (select corresponding number)
    \n 1. See your favorite drink
    \n 2. Find the highest rated brewery
    \n 3. Find the most popular brewery"
    user_input = gets.chomp
    cgi
    if user_input == "1"
        user.user_fav_drink
        pick_option(user)
    elsif user_input == "2"
        Bookmark.best_brewery
        pick_option(user)
    elsif user_input == "3"
        Bookmark.most_bookmarked_brewery
        pick_option(user)
    else
        invalid_input
        other_chosen(user)
    end
end

#Helper methods
def capital_first(string)
    string.split.map(&:capitalize).join(' ')
end

def invalid_input
    puts "Invalid input"
    cgi
    sleep 1.5
end

def cgi
    puts " "
    puts "~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~"
    puts "~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~~*~   ~*~"
    puts " "
end