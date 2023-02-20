require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters.push(("A".."Z").to_a.sample)
    end
  end

  def letter_in_grid(word, letters)
    word.upcase.chars.all? { |letter| word.upcase.count(letter) <= letters.count(letter)}
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_dictionary = URI.open(url).read
    worded = JSON.parse(word_dictionary)
    if worded['found'] && letter_in_grid(@word, @letters)
      @score = "Congratulations! #{@word} is a valid English word"
    else
      @score = "Sorry, but #{@word}, can't be built out of #{@letters}"
    end
  end
end
