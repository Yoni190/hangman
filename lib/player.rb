class Player
  attr_accessor :chances
  @@score = 0

  def initialize
    self.chances = 13
  end

  def display_score
    @@score
  end

  def increment_score
    @@score += 1
  end
end