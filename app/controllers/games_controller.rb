require "open-uri"

class GamesController < ApplicationController
  def new
    @charset = Array('A'..'Z').sample(10)
  end

  def score
    @answer = params['user_input'].upcase
    @letters = params[:charset].split
    @english_word = english_word?(@answer)
    @included = included?(@answer, @letters)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end


  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
