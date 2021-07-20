# require "open uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters=("A".."Z").to_a.sample(10)
  end
  
  def score(word, grid,time)
    if included?(word, grid)
      if english_word?(word)
        score = if time > 60
        0
        else word.length
        end
        [score, "Puntaje obtenido por tu palabra"]
      else
        [0, "Sorry! Tu palabra no está en el diccionario inglés"]
      end
      else
        [0, "Sorry! Te pasaste del límite de tiempo"]
      end
    end
  end 

def included?(word, grid)
  word.chars.all? { |char| word.count(char)<= grid.count(char) }
end
def english_word?(word)
  url = URL.open("https://wagon-dictionary.herokuapp.con/#{word}")
  json = JSON.parse(url.read)
  json["found"]
end
