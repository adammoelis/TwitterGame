class Game

    attr_accessor :score, :attempts, :percentage, :answer_status, :right_person

    @@max_games = 3

    def initialize(score, attempts)
      @score = score
      @attempts = attempts
    end

    def self.max_games
      @@max_games
    end

    def percentage
      @attempts > 0 ? 100*score/attempts : nil
    end

    def display_percentage
      percentage ? "#{percentage}%" : "N/A"
    end

    def feedback_class_type
      if percentage
        case percentage
          when 75..100
            "great"
          when 50...75
            "good"
          when 25...50
            "bad"
          else
            "terrible"
          end
      else
      end
    end

    def feedback_value
      if percentage
        case percentage
          when 75..100
            "Great Job!"
          when 50...75
            "Okay Job"
          when 25...50
            "You KINDA suck"
          else
            "You REALLY suck"
          end
        else
          "None Wrong ... yet"
      end
    end

    def display_after_answer
      if right_person
        if answer_status
          "Correct! #{right_person.name}"
        else
          "Wrong! It was #{right_person.name}"
        end
      else
      end
    end

    def tweet_button_message
      if percentage
        "I got #{display_percentage} right! How many can you get? #WhoTweetedIt"
      else
        "How many can you get? #WhoTweetedIt"
      end
    end

    def start_over
      "Start Over" if attempts > 0
    end




end
