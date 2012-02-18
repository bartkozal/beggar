module Beggar
  class CLI
    class << self
      def run
        Base.new(Basecamp.new(load_config))
      end

    private

      def load_config
        begin
          YAML.load_file(config)
        rescue Errno::ENOENT
          create_config
          puts "New config has been created in ~/.beggar"
          puts "Please fill it now with proper data."
        end
      end

      def create_config
        File.open(config, "w") do |output|
          YAML.dump(defaults, output)
        end
      end

      def defaults
        {
          "company" => "___",
          "token" => "___",
          "rate" => "___"
        }
      end

      def config
        "#{Dir.home}/.beggar"
      end
    end
  end
end

