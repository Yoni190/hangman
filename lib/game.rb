require_relative "dictionary"
require_relative "player"
require "json"

# This class unites all classes
class Game
  attr_accessor :dictionary, :player, :chosen_letter, :word, :letters_selected

  def initialize
    self.dictionary = Dictionary.new
    self.player = Player.new
    self.word = ""
    self.letters_selected = []

    greet_user

    create_blanks
    read_from_json if new_or_load == "2"
    play_game
  end

  def play_game
    display_info
    prompt_player
    check_choice
    clear_screen
    if !word.include?("_") # rubocop:disable Style/NegatedIfElseCondition
      win_message
    else
      player.chances.zero? ? lost : play_game
    end
    continue_game
  end

  def greet_user
    puts "\t\s\s--------------------------------------------------------------\n
          | \t\t\t Welcome to Hangman! \t\t\t|\n
          | \t\s\sA game where you either find the correct word \t|\n
          | \t\t\tor be hanged! Have fun \s\s\t\t|\n
          ---------------------------------------------------------------\n\n"
  end

  def display_info
    puts "Score: #{player.display_score}   \t\t\t Chances left: #{player.chances} \n
    Selected: #{letters_selected.join(', ')}\n #{word}"
  end

  def create_blanks
    dictionary.length_of_word.times { self.word += "_ " }
  end

  def prompt_player
    puts "\nEnter a letter: "
    self.chosen_letter = gets.chomp
    return unless chosen_letter == "save"

    save_to_json
  end

  def win_message
    puts word
    puts "Congrats! You've won"
    player.increment_score
  end

  def check_choice
    secret_word = dictionary.secret_word.chars.join(" ")
    if chosen_letter == "save" then puts "Saved successfully!"
    elsif secret_word.include?(chosen_letter)
      occurence = secret_word.count(chosen_letter)
      substitute_all_letters(occurence, secret_word)
    else
      player.chances -= 1
      add_letter(chosen_letter)
    end
  end

  def substitute_all_letters(occurence, secret_word)
    if occurence == 1 then substitute_blank(secret_word)
    else
      occurence.times { substitute_blank(secret_word) }
    end
  end

  def substitute_blank(secret_word)
    letter_index = secret_word.index(chosen_letter)
    self.word[letter_index] = chosen_letter
    secret_word[letter_index] = "_"
  end

  def lost
    puts "The word was #{dictionary.secret_word}"
    puts "You've lost"
  end

  def continue_game
    puts "Do you want to continue?[Y/N]"
    response = gets.chomp
    response.upcase == "Y" ? Game.new : exit
  end

  def add_letter(letter)
    letters_selected.include?(letter) ? letters_selected : letters_selected.push(letter)
  end

  def clear_screen
    puts "\e[1;1H\e[2J"
  end

  def save_to_json
    data = {
      score: player.display_score,
      chances: player.chances,
      word: self.word,
      secret_word: dictionary.secret_word,
      letters_selected: letters_selected
    }
    json_data = JSON.generate(data)
    File.write("myFile.json", json_data)
  end

  def read_from_json
    data = JSON.load(File.open("myFile.json")) # rubocop:disable Security/JSONLoad

    player.assign_score(data["score"])
    player.chances = data["chances"]
    self.word = data["word"]
    dictionary.secret_word = data["secret_word"]
    self.letters_selected = data["letters_selected"]
  rescue StandardError
    puts "Game file not found"
    Game.new
  end

  def new_or_load
    puts "1. Play a new game\n
    2. Load an existing game"
    gets.chomp
  end
end
