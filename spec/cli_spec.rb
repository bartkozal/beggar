require 'beggar'

describe Beggar::CLI do
  let(:config) { "#{Dir.home}/.beggar" }

  before do
    Beggar::Basecamp.stub(new: double('Basecamp'))
  end

  after do
    Beggar::CLI.run
  end

  context 'config file exists' do
    it "loads it before running" do
      YAML.should_receive(:load_file).with(config).and_return(double('configuration'))
    end
  end

  context 'config file not exists' do
    let(:default_config) {
      {
        "company" => "___",
        "token" => "___",
        "rate" => "___"
      }
    }

    before do
      YAML.should_receive(:load_file).with(config) { raise Errno::ENOENT }
    end

    it "creates config with default settings" do
      $stdout.stub(:puts)
      output = double('output')
      File.should_receive(:open).with(config, "w").and_yield(output)
      YAML.should_receive(:dump).with(default_config, output)
    end

    it 'displays notification for user' do
      Beggar::CLI.stub(:create_config)
      $stdout.should_receive(:puts).with("New config has been created in ~/.beggar")
      $stdout.should_receive(:puts).with("Please fill it now with proper data.")
    end
  end
end
