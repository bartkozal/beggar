# encoding: utf-8

module Beggar
  class Salary
    class << self
      attr_accessor :rate

      def from_basecamp
        Hours.from_basecamp * rate
      end

      def up_today
        Hours.up_today * rate
      end

      def difference
        up_today - from_basecamp
      end

      def to_s
        %[#{from_basecamp} PLN ± #{difference} PLN]
      end
    end
  end
end
