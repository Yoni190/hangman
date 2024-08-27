require_relative 'dictionary'

class Game
  attr_accessor :dictionary, :chosen_letter

  def initialize
    self.dictionary = Dictionary.new
    greet_user
    prompt_player
  end

  def greet_user
    puts "\t\s\s--------------------------------------------------------------\n
          | \t\t\t Welcome to Hangman! \t\t\t|\n
          | \t\s\sA game where you either find the correct word \t|\n
          | \t\t\tor be hanged! Have fun \s\s\t\t|\n
          ---------------------------------------------------------------\n\n"
  end



  def prompt_player
    puts "Enter a letter: "
    self.chosen_letter = gets.chomp
  end

  

end