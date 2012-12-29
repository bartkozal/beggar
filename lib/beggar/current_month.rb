require 'holidays'

module Beggar
  class CurrentMonth
    def initialize(options = {})
      @country = options[:country]
    end

    def workdays
      workdays_until(last_day)
    end

    def workdays_until_today
      workdays_until(today)
    end

    def workday_hours
      workdays * 8.0
    end

    def workday_hours_until_today
      workdays_until_today * 8.0
    end

    def workdays_progression
      (workdays_until_today * 100.0 / workdays).round
    end

    def workdays_until(date)
      (first_day..date).reject { |d|
        [0, 6].include?(d.wday) || d.holiday?(@country) }.length
    end

    def first_day
      Date.new(year, month, 1)
    end

    def last_day
      first_day.next_month - 1
    end

    def year
      today.year
    end

    def month
      today.month
    end

    def today
      Date.today
    end
  end
end

