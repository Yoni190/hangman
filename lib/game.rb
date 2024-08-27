require_relative 'dictionary'
require_relative 'player'

class Game
  attr_accessor :dictionary, :player, :chosen_letter, :word

  def initialize
    self.dictionary = Dictionary.new
    self.player = Player.new
    self.word = ""

    create_blanks
    play_game
  end

  def play_game
    greet_user
    display_score_and_chances
    puts word
    prompt_player
    check_choice
    if win?
      puts word
      puts "Congrats! You've won"
      player.increment_score
    else
      player.chances -= 1
      player.chances.zero? ? lost : play_game
    end
    continue
  end

  def greet_user
    puts "\t\s\s--------------------------------------------------------------\n
          | \t\t\t Welcome to Hangman! \t\t\t|\n
          | \t\s\sA game where you either find the correct word \t|\n
          | \t\t\tor be hanged! Have fun \s\s\t\t|\n
          ---------------------------------------------------------------\n\n"
  end

  def display_score_and_chances
    puts "Score: #{player.display_score}   \t\t\t Chances left: #{player.chances}"
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
    secret_word = dictionary.secret_word.split("").join(" ")
    if secret_word.include?(chosen_letter)
      occurence = secret_word.count(chosen_letter)
      if occurence == 1
        substitute_blank(secret_word)
      else
        occurence.times{
          substitute_blank(secret_word)
        }
      end
    end
  end

  def substitute_blank(secret_word)
        letter_index = secret_word.index(chosen_letter)
        self.word[letter_index] = chosen_letter
        secret_word[letter_index] = "_"
  end

  def win?
    !word.include?("_")
  end

  def lost
    puts "The word was #{dictionary.secret_word}"
    puts "You've lost"
  end

  def continue
    puts "Do you want to continue?[Y/N]"
    if gets.chomp == "Y"
      Game.new
    end
  end

  

end