# encoding: utf-8

module Beggar
  class Base
    def initialize(config)
      Basecamp.establish_connection!("#{config['company']}.basecamphq.com", config['token'], 'X', true)

      Hours.project_id = config['project']['id']
      Salary.rate = config['project']['rate']
    end

    def self.me
      @@me ||= Basecamp::Person.me
    end

    def summary
      [CurrentMonth, Hours, Salary].join(' || ')
    end
  end
end
