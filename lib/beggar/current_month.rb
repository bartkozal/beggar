module Beggar
  class CurrentMonth
    class << self
      def weekdays
        weekdays_until(last_day)
      end

      def weekdays_until_today
        weekdays_until(today)
      end

      def weekday_hours
        weekdays * 8.0
      end

      def weekday_hours_until_today
        weekdays_until_today * 8.0
      end

      def days_progression
        (weekdays_until_today * 100.0 / weekdays).round
      end

      def weekdays_until(date)
        (first_day..date).reject { |d| [0, 6].include? d.wday }.length
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
end

