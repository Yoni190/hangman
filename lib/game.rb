require_relative 'dictionary'

class Game
  attr_accessor :dictionary

  def initialize
    self.dictionary = Dictionary.new
    greet_user
  end

  def greet_user
    puts "\t\s\s--------------------------------------------------------------\n
          | \t\t\t Welcome to Hangman! \t\t\t|\n
          | \t\s\sA game where you either find the correct word \t|\n
          | \t\t\tor be hanged! Have fun \s\s\t\t|\n
          ---------------------------------------------------------------\n\n"
  end

  

end