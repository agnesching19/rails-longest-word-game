require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def word_in_grid?(word, grid)
    word.upcase.split("").all? {|char| word.count(char) <= grid.count(char) }
  end

  def score
    grid = params[:grid].split("")
    word = params[:answer]
    @score = {}
    if english_word?(word) && word_in_grid?(word, grid)
      @score[:message] = "Well done"
      @score[:result] = 5
    elsif english_word?(word)
      @score[:message] = "Sorry it's out of the grid"
    else
      @score[:message] = "Sorry it's not a valid English word"
    end
  end
end
