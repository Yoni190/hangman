require_relative 'dictionary'

class Game
  attr_accessor :dictionary, :chosen_letter, :word

  def initialize
    self.dictionary = Dictionary.new
    self.word = ""

    create_blanks
    play_game
  end

  def play_game
    greet_user
    puts word
    prompt_player
    check_choice
  end

  def greet_user
    puts "\t\s\s--------------------------------------------------------------\n
          | \t\t\t Welcome to Hangman! \t\t\t|\n
          | \t\s\sA game where you either find the correct word \t|\n
          | \t\t\tor be hanged! Have fun \s\s\t\t|\n
          ---------------------------------------------------------------\n\n"
  end

  def create_blanks
    dictionary.length_of_word.times{
      self.word += "_ "
    }
  end

  def prompt_player
    puts "\nEnter a letter: "
    self.chosen_letter = gets.chomp
  end

  def check_choice
    secret_word = dictionary.secret_word
    if secret_word.include?(chosen_letter)
      occurence = secret_word.count(chosen_letter)
      if occurence == 1
        letter_index = secret_word.index(chosen_letter)
        self.word[letter_index] = chosen_letter
        secret_word[letter_index] = "_"
      else
        occurence.times{
          letter_index = secret_word.index(chosen_letter)
          self.word[letter_index] = chosen_letter
          secret_word[letter_index] = "_"
        }
      end
    end
    play_game
  end

  

  

end