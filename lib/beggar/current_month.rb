module Beggar
  class CurrentMonth
    class << self
      def first_day
        Date.new(Date.today.year, Date.today.month, 1)
      end

      def last_day
        first_day.next_month - 1
      end

      def working_days(last_day = last_day)
        (first_day..last_day).reject { |d| [0,6].include? d.wday }.size
      end

      def working_days_up_today
        working_days(Date.today)
      end

      def to_s
        %[#{(working_days_up_today.to_f / working_days * 100).round}%]
      end
    end
  end
end
