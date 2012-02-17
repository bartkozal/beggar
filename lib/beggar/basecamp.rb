module Beggar
  class Basecamp
    include HTTParty

    def initialize(configuration)
      @configuration = configuration

      self.class.base_uri "https://#{@configuration['company']}.basecamphq.com"
      self.class.basic_auth @configuration['token'], 'X'
    end

    def user_id
      @user_id ||= self.class.get('/me.xml')['person']['id']
    end

    def report(options = {})
      options.merge!( subject_id: user_id )
      self.class.get('/time_entries/report.xml', options)
    end
  end
end
