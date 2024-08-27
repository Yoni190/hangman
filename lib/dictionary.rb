class Dictionary
  attr_accessor :words, :secret_word

  def initialize
    self.words = load_dictionary.split(" ")
    self.secret_word = choose_secret_word.sample
    puts secret_word
  end

  def load_dictionary
    File.read("google-10000-english-no-swears.txt")
  end

  def choose_secret_word
    valid_words = words.filter{|word| word.length.between?(5,12)}
    valid_words
  end
end