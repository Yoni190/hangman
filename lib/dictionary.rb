class Dictionary
  attr_accessor :words, :secret_word

  def initialize
    self.words = load_dictionary.split(" ")
  end

  def load_dictionary
    File.read("google-10000-english-no-swears.txt")
  end
end