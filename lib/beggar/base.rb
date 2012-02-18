module Beggar
  class Base
    def initialize(basecamp)
      @basecamp = basecamp
    end

    def progress
      "#{CurrentMonth.days_progression}%"
    end

    def worked_hours
      "#{@basecamp.worked_hours}h, #{ratio(@basecamp.hours_ratio)}h"
    end

  private

    def ratio(number)
      (number > 0) ? "-#{number}" : "+#{number.abs}"
    end
  end
end

