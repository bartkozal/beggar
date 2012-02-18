# encoding: utf-8
module Beggar
  class Base
    attr_accessor :basecamp

    def initialize(basecamp)
      @basecamp = basecamp
    end

    def progress
      "#{CurrentMonth.days_progression}%"
    end

    def worked_hours
      "#{basecamp.worked_hours}h, #{ratio(basecamp.hours_ratio)}h"
    end

    def salary
      "#{as_money(basecamp.worked_hours)} zł, #{ratio(as_money(basecamp.hours_ratio))} zł"
    end

  private

    def as_money(hours)
      hours * basecamp.config.rate
    end

    def ratio(number)
      (number > 0) ? "-#{number}" : "+#{number.abs}"
    end
  end
end

