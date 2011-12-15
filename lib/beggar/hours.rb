# encoding: utf-8

module Beggar
  class Hours
    class << self
      attr_accessor :project_id

      def worked
        params = { project_id: project_id, from: CurrentMonth.first_day, to: Date.today }
        @@worked ||= Basecamp::TimeEntry.report(params).select { |te| te.person_id == Base.me.id }.map(&:hours).inject(&:+)
      end

      def max_up_today
        CurrentMonth.working_days_up_today * 8
      end

      def difference
        max_up_today - worked
      end

      def to_s
        %[#{worked}h ± #{difference}h]
      end
    end
  end
end
