module Beggar
  class Base
    def initialize(basecamp)
      @basecamp = basecamp
    end

    def progress
      "#{days_progression}%"
    end

    def worked_hours
      CurrentMonth.weekday_hours
    end

  private

    def days_progression
      (CurrentMonth.weekdays_until_today * 100.0 / CurrentMonth.weekdays).round
    end
  end
end

