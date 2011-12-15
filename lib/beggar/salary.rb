# encoding: utf-8

module Beggar
  class Salary
    class << self
      attr_accessor :rate

      def today
        Hours.worked * rate
      end

      def max_up_today
        Hours.max_up_today * rate
      end

      def difference
        max_up_today - today
      end

      def to_s
        %[#{today} PLN ± #{difference} PLN]
      end
    end
  end
end
