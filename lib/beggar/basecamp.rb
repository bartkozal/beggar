module Beggar
  class Basecamp
    include HTTParty

    attr_accessor :config

    def initialize(paresed_yaml)
      config = paresed_yaml

      self.class.base_uri("https://#{config['company']}.basecamphq.com")
      self.class.basic_auth(config['token'], 'X')
    end

    def current_user
      @current_user ||= get('/me.xml')['person']['id']
    end

    def time_report(options = {})
      options.merge!( subject_id: current_user )
      get(%(/time_entries/report.xml#{params(options)}))
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
