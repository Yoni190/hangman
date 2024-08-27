# This class keeps track of player score and chances
class Player
  attr_accessor :chances

  @@score = 0 # rubocop:disable Style/ClassVars

  def initialize
    self.chances = 13
  end

  def display_score
    @@score
  end

  def assign_score(score)
    @@score = score # rubocop:disable Style/ClassVars
  end

  def increment_score
    @@score += 1 # rubocop:disable Style/ClassVars
  end
end
