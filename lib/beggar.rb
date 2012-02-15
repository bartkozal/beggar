require 'yaml'

module Beggar
  class CLI
    class << self
      def run
        load_configuration
      end

    private

      def load_configuration
        begin
          YAML.load_file(configuration_file_path)
        rescue Errno::ENOENT
          save_default_configuration
          puts "Saved a new configuration file in ~/.beggar. Please fill it with proper data."
        end
      end

      def save_default_configuration
        File.open(configuration_file_path, "w") do |output|
          YAML.dump(default_configuration, output)
        end
      end

      def default_configuration
        {
          "company" => "your_company_name",
          "token" => "your_basecamp_token",
          "projects" => {
            "project_id" => {
              "rate" => "your_rate"
            }
          }
        }
      end

      def configuration_file_path
        "#{Dir.home}/.beggar"
      end
    end
  end
end
