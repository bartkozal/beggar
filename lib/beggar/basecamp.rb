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

    def current_month
      @current_month ||= time_report(from: CurrentMonth.first_day, to: CurrentMonth.today)
    end

    def worked_hours
      time_entries = current_month['time_entries']
      return 0 if time_entries.empty?
      time_entries.map do |entry|
        entry['hours']
      end.inject(:+)
    end

    def hours_ratio
      CurrentMonth.weekday_hours_until_today - worked_hours
    end
  end
end
