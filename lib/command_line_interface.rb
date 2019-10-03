def wheres_beer
    puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
    puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
    puts "WHERE'S BEER?... in CA"
    puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
    puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
    sleep 2
end

def welcome
    puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
    puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
    puts "Hello, beer friend!"
    sleep 1.25
    puts "Would you like to create an account or login?"
    puts "Enter 1 to create account. Enter 2 to login using your id."
    puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
    puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
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
            puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
            puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
            puts "Your user id is #{new_user.id}. Remember your user id to login in the future!"
            return new_user
        else 
            puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
            puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
            puts "Please enter valid 10-digit phone number (no extra character, just numbers!)"
            create_or_login("1")
        end
    elsif value == "2"
        puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
        puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
        puts "Please enter your user id."
        user_id = gets.chomp.to_i
        saved_user = User.find_by(id: user_id)
        if saved_user
            puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
            puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
            puts "Welcome back #{saved_user.name}. Happy drinking!"
            return saved_user
        else 
            puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
            puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
            puts "Invalid input."
            welcome
        end
    else
        puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
        puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
        puts "Invalid input."
        welcome
    end

   

end

def pick_option(user)
    puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
    puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
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
        user = welcome
        pick_option(user)
    else
        puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
        puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
        puts "Invalid input"
        pick_option(user)
    end
    
end


def find_chosen(user)
    puts "How would you like to search? (Enter corresponding number)
    \n 1. Find Brewery by phone number
    \n 2. Find Breweries with your area code
    \n 3. Find Breweries by City & Brewery Type
    \n 4. Find Brewery by name
    \n 5. Find Breweries in your city"
    user_input = gets.chomp
    if user_input == "1" 
        puts "Please enter 10 digit phone number without extra characters (ex: 0000000000)"
        brew_phone_number = gets.chomp
        if brew_phone_number.to_i.to_s == brew_phone_number && brew_phone_number.length == 10 
            brewery = Brewery.find_by(phone_number: brew_phone_number)
            if brewery 
            puts "Brewery found! #{brewery.name} in #{brewery.city}, CA. Phone number: #{brewery.phone_number}"
            pick_option(user)
            else 
                puts "Invalid input"
                find_chosen(user)
            end
        else
            puts "Please enter a valid phone number"
            find_chosen(user)
        end
    elsif user_input == "2"
        Brewery.find_breweries_match_users_areacode(user.phone_number[0...3])
        pick_option(user)
    elsif user_input == "3" 
        puts "Please enter the city"
        city = gets.chomp
        puts "Please enter a brewery type"
        puts "Please select from these options: (enter type exactly how it is shown)
        \n brewpub, micro, planning, regional, proprietor, contract, large"
        brewery_type = gets.chomp
        brewery = Brewery.brewery_by_city_and_type(city, brewery_type)
        if brewery 
            puts "Here's a list of #{brewery_type} Breweries in #{city}:\n\n"
            brewery.map do |brwy|
                if brwy.phone_number.length == 10
                    puts "#{brwy.name}, phone: #{brwy.phone_number}"
                else
                    puts "#{brwy.name}, phone: N/A"
                end
            end
            pick_option(user)
            
        else 
            puts "Invalid input"
            find_chosen(user)
        end
    elsif user_input == "4"
        puts "Please enter Brewery's name"
        name = gets.chomp
        brewery = Brewery.find_by(name: name)
        if brewery
            puts "Brewery found! Here is their info:"
            if brewery.phone_number.length == 10
                puts "#{brewery.name} is located in #{brewery.city}, CA. Their phone number is: #{brewery.phone_number}"
            else
                puts "#{brewery.name} is located in #{brewery.city}, CA."
            end
            pick_option(user)
        else
            puts "Invalid input"
            find_chosen(user)
        end
    elsif user_input == '5'
        city_brews = Brewery.select('id, name, phone_number').where('city = ?', user.city)    
       
        if city_brews.length > 0
            puts "Breweries found!"
            city_brews.each do |cb|
                if cb.phone_number.length == 10
                    puts "#{cb.name}, phone number: #{cb.phone_number}"
                else
                    puts "#{cb.name}"
                end
            end
            pick_option(user)
        else
            puts "Invalid input"
            find_chosen(user)
        end
    else 
        puts "Invalid input"
        find_chosen(user)
    end
end

def bookmark_chosen(user)
    puts "Would you like to Bookmark using the Brewery's name or phone number?
    \n Enter 1 for name & 2 for phone number"
    bm_identifier = gets.chomp
    if bm_identifier == "1"
        puts "Please enter Brewery's name"
        name = gets.chomp
        brewery = Brewery.find_by(name: name)
        if brewery
            puts "Brewery found! Please tell us a little more to save your bookmark...
            \n Rate the Brewery (1-5)"
            rating = gets.chomp
            puts "What was your favorite drink?"
            favorite = gets.chomp
            Bookmark.create(brewery_id: brewery.id, user_id: user.id, rating: rating, favorite: favorite)
            puts "Bookmark saved!"
            pick_option(user)
        else 
            puts "Invalid input"
            bookmark_chosen(user)
        end
    elsif bm_identifier == "2"
        puts "Please enter Brewery's phone number"
        phone_number = gets.chomp
        brewery = Brewery.find_by(phone_number: phone_number)
        if brewery
            puts "Brewery found! Please tell us a little more to save your bookmark...
            \n Rate the Brewery (1-5)"
            rating = gets.chomp
            puts "What was your favorite drink?"
            favorite = gets.chomp
            Bookmark.create(brewery_id: brewery.id, user_id: user.id, rating: rating, favorite: favorite)
            puts "Bookmark saved!"
            pick_option(user)
            
        else 
            puts "Invalid input"
            bookmark_chosen(user)
        end
    else
        puts "Invalid input"
        bookmark_chosen(user)
    end
end

def update_chosen(user)
    puts "What would you like to update?"
    puts "Please choose the corresponding number:
    \n 1. name
    \n 2. phone_number
    \n 3. current city"
    user_input = gets.chomp
    if user_input == "1"
        puts "Please input your new name."
        new_name = gets.chomp
        x = User.update(user.id, name: new_name)
        puts "Your name has been updated to #{new_name}"
        pick_option(user)
    elsif user_input == "2"
        puts "Please input your new phone number."
        new_number = gets.chomp
        User.update(user.id, phone_number: new_number)
        puts "Your phone number has been updated to #{new_number}"
        pick_option(user)
    elsif user_input == "3"
        puts "Please input your new city."
        new_city = gets.chomp
        User.update(user.id, city: new_city)
        puts "Your city has been updated to #{new_city}"
        pick_option(user)
    else
        puts "Invalid input"
        update_chosen(user)
    end
end

def other_chosen(user)
    puts "Would you like to: (select corresponding number)
    \n 1. See your favorite drink
    \n 2. Find the highest rated brewery
    \n 3. Find the most popular brewery"
    user_input = gets.chomp
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
        puts "Invalid input"
        other_chosen(user)
    end
end