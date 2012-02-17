module Beggar
  class CurrentMonth
    class << self
      def weekdays
        weekdays_until(last_day)
      end

      def weekdays_until_today
        weekdays_until(Date.today)
      end

    private

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
        Date.today.year
      end

      def month
        Date.today.month
      end
    end
  end
end

