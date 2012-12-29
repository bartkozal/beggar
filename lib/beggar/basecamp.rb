module Beggar
  class Basecamp
    include HTTParty

    attr_accessor :config

    def initialize(config)
      @config = config

      self.class.base_uri("https://#{config['company']}.basecamphq.com")
      self.class.basic_auth(config['token'], 'X')
    end

    def time_report(options = {})
      options.merge!(subject_id: current_user)
      self.class.get("/time_entries/report.xml", :query => options)
    end

    def current_user
      @current_user ||= self.class.get('/me.xml')['person']['id']
    end

    def current_month_report
      @current_month_report ||= time_report(from: current_month.first_day, to: current_month.today)
    end

    def worked_hours
      time_entries = current_month_report['time_entries']
      return 0 if time_entries.empty?
      time_entries.map do |entry|
        entry['hours']
      end.inject(:+)
    end

    def hours_ratio
      current_month.workday_hours_until_today - worked_hours
    end

    def workdays_progression
      current_month.workdays_progression
    end

    def current_month
      @current_month ||= CurrentMonth.new(:country => @config['country'])
    end
  end
end
