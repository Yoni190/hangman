require_relative 'dictionary'

class Game
  attr_accessor :dictionary, :chosen_letter, :word

  def initialize
    self.dictionary = Dictionary.new
    self.word = ""
    play_game
  end

  def play_game
    greet_user
    display_blanks
    prompt_player
  end

  def greet_user
    puts "\t\s\s--------------------------------------------------------------\n
          | \t\t\t Welcome to Hangman! \t\t\t|\n
          | \t\s\sA game where you either find the correct word \t|\n
          | \t\t\tor be hanged! Have fun \s\s\t\t|\n
          ---------------------------------------------------------------\n\n"
  end

  def display_blanks
    dictionary.length_of_word.times{
      self.word += "_ "
    }
    puts word
  end

  def prompt_player
    puts "\nEnter a letter: "
    self.chosen_letter = gets.chomp
  end

  

end