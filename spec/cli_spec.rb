require 'beggar'

describe Beggar::CLI do
  let(:config) { "#{Dir.home}/.beggar" }

  before do
    $stdout.stub(:puts)
    Beggar::Basecamp.stub(new: double('Basecamp'))
    Beggar::Base.stub_chain(:new, :summary)
  end

  after do
    -> { Beggar::CLI.run }.should raise_error { SystemExit }
  end

  context 'when config file exists' do
    before do
      File.stub(:exists?).and_return(true)
    end

    it "loads it before running" do
      YAML.should_receive(:load_file).with(config).and_return(double('configuration'))
    end
  end

  context 'when config file not exists' do
    let(:default_config) {
      {
        "company" => "___",
        "token" => "___",
        "rate" => "___"
      }
    }

    before do
      File.stub(:exists?).and_return(false)
    end

    it "creates config with default settings" do
      output = double('output')
      File.should_receive(:open).with(config, "w").and_yield(output)
      YAML.should_receive(:dump).with(default_config, output)
    end

    it 'displays notification' do
      $stdout.unstub(:puts)
      Beggar::CLI.stub(:create_config)
      $stdout.should_receive(:puts).with("New config has been created in ~/.beggar")
      $stdout.should_receive(:puts).with("Please fill it with proper data.")
    end
  end

  context 'when config file is wrong' do
    it 'displays notification' do
      $stdout.unstub(:puts)
      File.stub(:exists?) { raise URI::InvalidURIError }
      $stdout.should_receive(:puts).with("Ensure that your config file is proper formatted!")
    end
  end
end

