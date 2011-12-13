# encoding: utf-8

module Beggar
  class Hours
    class << self
      attr_accessor :project_id

      def from_basecamp
        @@from_basecamp ||= Basecamp::TimeEntry.report(project_id: project_id, from: CurrentMonth.first_day, to: Date.today).map(&:hours).inject(&:+)
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
end
