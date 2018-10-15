require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    grid = []
    10.times { grid << ('A'..'Z').to_a[rand(25)] }
    @letters = grid
  end

  def score
    @word = params[:word].downcase
    @url = 'https://wagon-dictionary.herokuapp.com/'
    @result = JSON.parse(open('https://wagon-dictionary.herokuapp.com/' + @word).read)
    @word_array = @word.upcase.chars
    @letters = params[:letters].upcase.split(" ")
    if @word_array.all? { |letter| @letters.include?(letter) && (@letters.count(letter) >= @word_array.count(letter)) }
      if @result['found']
        @message = "Congratulations! #{@word.upcase} is a valid English word!"
      else
        @message = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
      end
    else
      @message = "Sorry but #{@word.upcase} is not inluded in #{@letters.join(', ')}"
    end
  end
end
