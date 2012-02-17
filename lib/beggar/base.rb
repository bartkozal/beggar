module Beggar
  class Base
    def initialize(basecamp)
      @basecamp = basecamp
    end

    def progress
      "#{CurrentMonth.days_progression}%"
    end

    def worked_hours
      CurrentMonth.weekday_hours
    end
  end
end

