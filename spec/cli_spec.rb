require 'beggar'

describe Beggar::CLI do
  it "should load configuration on run" do
    Beggar::CLI.should_receive(:load_configuration)
    Beggar::CLI.run
  end

  context "load configuration" do
    before do
      @home = Dir.home
    end

    it "returns hash with options from yml file" do
      configuration = YAML.load_file(File.expand_path(__FILE__, 'fixtures/beggar'))
      YAML.should_receive(:load_file).with("#@home/.beggar").and_return(configuration)
      Beggar::CLI.run
    end

    it "creates .beggarc when config doesn't exists" do
      default_configuration = {
        "company" => "your_company_name",
        "token" => "your_basecamp_token",
        "projects" => {
          "project_id" => {
            "rate" => "your_rate"
          }
        }
      }
      output = double()
      YAML.should_receive(:load_file).with("#@home/.beggar") { raise Errno::ENOENT }
      File.should_receive(:open).with("#@home/.beggar", "w").and_yield(output)
      YAML.should_receive(:dump).with(default_configuration, output)
      $stdout.should_receive(:puts).with("Saved a new configuration file in ~/.beggar. Please fill it with proper data.")
      Beggar::CLI.run
    end
  end
end
