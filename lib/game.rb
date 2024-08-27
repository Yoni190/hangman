require_relative 'dictionary'
require_relative 'player'
require 'json'

class Game
  attr_accessor :dictionary, :player, :chosen_letter, :word, :letters_selected

  def initialize
    self.dictionary = Dictionary.new
    self.player = Player.new
    self.word = ""
    self.letters_selected = []

    greet_user
    
    create_blanks
    if new_or_load == "2"
      read_from_json
    end
    play_game
  end

  def play_game
    
    display_score_and_chances
    puts word
    prompt_player
    check_choice
    clear_screen
    if win?
      puts word
      puts "Congrats! You've won"
      player.increment_score
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

  def display_score_and_chances
    puts "Score: #{player.display_score}   \t\t\t Chances left: #{player.chances} \n Selected: #{letters_selected.join(", ")}"
  end

  def create_blanks
    dictionary.length_of_word.times{
      self.word += "_ "
    }
  end

  def prompt_player
    puts "\nEnter a letter: "
    self.chosen_letter = gets.chomp
    if chosen_letter == "save"
      save_to_json
    end
  end

  def check_choice
    secret_word = dictionary.secret_word.split("").join(" ")
    if chosen_letter == "save"
      puts "Saved successfully!"
    elsif secret_word.include?(chosen_letter)
      occurence = secret_word.count(chosen_letter)
      if occurence == 1
        substitute_blank(secret_word)
      else
        occurence.times{
          substitute_blank(secret_word)
        }
      end
    else
      player.chances -= 1
      add_letter(chosen_letter)
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
      letters_selected: self.letters_selected
    }
    json_data = JSON.generate(data)
    File.open("myFile.json", "w") do |file|
    file.write(json_data)
    end
  end

  def read_from_json
    json_data = File.open("myFile.json")
    data = JSON.load(json_data)
    
    player.set_score(data["score"])
    player.chances = data["chances"]
    self.word = data["word"]
    dictionary.secret_word = data["secret_word"]
    self.letters_selected = data["letters_selected"]
  end

  def new_or_load
    puts "1. Play a new game\n
    2. Load an existing game"
    gets.chomp
  end

  

end