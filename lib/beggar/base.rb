module Beggar
  class Base
    def initialize(basecamp)
      @basecamp = basecamp
    end

    def progress
      (current_month_wdays_until(Date.today) / current_month_wdays.to_f * 100).round.to_s + "%"
    end

private

    def current_month_wdays
      current_month_wdays_until(current_month_last_day)
    end

    def current_month_wdays_until(date)
      (current_month_first_day..date).reject { |d| [0, 6].include? d.wday }.length
    end

    def current_month_first_day
      year = Date.today.year
      month = Date.today.month
      Date.new(year, month, 1)
    end

    def current_month_last_day
      current_month_first_day.next_month - 1
    end
  end
end

