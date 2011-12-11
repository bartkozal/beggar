require 'basecamp'

module Beggar
  class Base
    def initialize(config)
      Basecamp.establish_connection!("#{config['company']}.basecamphq.com", config['token'], 'X', true)
    end
    
    def summary
    end
  end
end
