module Beggar
  class CLI
    class << self
      def run
        if File.exists?(config)
          $stdout.puts Base.new(Basecamp.new(load_config)).summary
        else
          create_config
          $stdout.puts "New config has been created in ~/.beggar"
          $stdout.puts "Please fill it with proper data."
        end
        exit 0
      rescue URI::InvalidURIError
        $stdout.puts "Ensure that your config file is proper formatted!"
      end

      private

        def load_config
          YAML.load_file(config)
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

