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
      options.merge!( subject_id: current_user )
      get(%(/time_entries/report.xml#{params(options)}))
    end

    def current_user
      @current_user ||= get('/me.xml')['person']['id']
    end

    def current_month
      @current_month ||= time_report(from: CurrentMonth.first_day, to: CurrentMonth.today)
    end

    def worked_hours
      current_month['time_entries'].map do |entry|
        entry['hours']
      end.inject(:+)
    end

    def hours_ratio
      CurrentMonth.weekday_hours_until_today - worked_hours
    end

  private

    def get(path)
      self.class.get(path)
    end

    def params(options)
      '?' + options.map { |name, value| "#{name}=#{value}" }.join('&')
    end
  end
end
