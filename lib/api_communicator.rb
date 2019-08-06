require 'rest-client'
require 'json'
require 'pry'

def get_character_hash(character_name, response_hash)
  character_hash = response_hash["results"].find do |character_info| 
      if character_info["name"] == character_name
        return character_info
      end
  end
end

#returns an Array of films
def get_character_films_array(character_name, response_hash)
  get_character_hash(character_name, response_hash)["films"]
end


#returns the json hash
def get_character_movies_from_api(character_name)
  response_string = RestClient.get("http://www.swapi.co/api/people/")
  response_hash = JSON.parse(response_string)
end



def request_movie_hash(film_array)
  # some iteration magic and puts out the movies in a nice list
  film_array.map do |film|
    r_string = RestClient.get(film)
    r_hash = JSON.parse(r_string)
    r_hash["title"]
  end
  
end

def print_movie_titles(movie_title_array)
  movie_title_array.each_with_index { |title, index|
    puts "#{index + 1}. #{title}"
  }
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end


name = "Luke Skywalker"
response_hash = get_character_movies_from_api(name)
film_array = get_character_films_array(name, response_hash)
title_array = request_movie_hash(film_array)
print_movie_titles(title_array)
binding.pry
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
