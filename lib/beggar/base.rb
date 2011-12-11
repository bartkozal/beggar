# encoding: utf-8
require 'basecamp'

module Beggar
  class Base
    def initialize(config)
      Basecamp.establish_connection!("#{config['company']}.basecamphq.com", config['token'], 'X', true)

      Hours.project_id = config['project']['id']
      Salary.rate = config['project']['rate']
    end

    def summary
      [CurrentMonth, Hours, Salary].join(' || ') + "\n"
    end
  end

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

  class Hours
    class << self
      attr_accessor :project_id

      def from_basecamp
        Basecamp::TimeEntry.report(project_id: project_id, from: CurrentMonth.first_day, to: Date.today).map(&:hours).inject(&:+)
      end

      def up_today
        CurrentMonth.working_days_up_today * 8
      end

      def difference
        up_today - from_basecamp
      end

      def to_s
        %[#{from_basecamp}h ± #{difference}h]
      end
    end
  end

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
