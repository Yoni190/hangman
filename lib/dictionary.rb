# This class loads 10000 words and chooses a word randomly
class Dictionary
  attr_accessor :words, :secret_word

  def initialize
    self.words = load_dictionary.split
    self.secret_word = choose_secret_word.sample
  end

  def length_of_word
    secret_word.length
  end

  private

  def load_dictionary
    File.read("google-10000-english-no-swears.txt")
  end

  def choose_secret_word
    words.filter { |word| word.length.between?(5, 12) }
  end
end
