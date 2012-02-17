module Beggar
  class Basecamp
    include HTTParty

    def initialize(configuration)
      @configuration = configuration

      self.class.base_uri "https://#{@configuration['company']}.basecamphq.com"
      self.class.basic_auth @configuration['token'], 'X'
    end

    def me
      @me ||= get('/me.xml')['person']['id']
    end

    def projects
      @projects ||= get('/projects.xml')['projects'].map do |project|
        project['id'] if project['status'] == 'active'
      end.compact
    end

    def report(options = {})
      options.merge!( subject_id: me )
      get(%(/time_entries/report.xml#{parse_headers(options)}))
    end

    def parse_headers(headers)
      '?' + headers.map { |n, v| n.to_s + '=' + v.to_s }.join('&')
    end

  private

    def get(path)
      self.class.get(path)
    end
  end
end
