class Game

    attr_accessor :score, :attempts, :percentage

    def initialize(score, attempts)
      @score = score
      @attempts = attempts
    end

    def percentage
      @attempts > 0 ? 100*score/attempts : nil
    end

    def display_percentage
      percentage ? "#{percentage}%" : "N/A"
    end




end
