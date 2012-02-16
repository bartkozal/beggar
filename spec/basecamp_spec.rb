require 'beggar'

describe Beggar::Basecamp do
  before do
    @configuration = YAML.load_file(File.expand_path('../fixtures/beggar', __FILE__))
    @basecamp = Beggar::Basecamp.new(@configuration)
  end

  describe 'init HTTParty' do
    after do
      Beggar::Basecamp.new(@configuration)
    end

    it 'set up base uri with company name' do
      Beggar::Basecamp.should_receive(:base_uri).with('https://Apple.basecamphq.com')
    end

    it 'set up basic auth' do
      Beggar::Basecamp.should_receive(:basic_auth).with('abc123', 'X')
    end
  end

  describe '#user_id' do
    it 'returns user id' do
      response = { 'person' => { 'id' => 1 }}
      @basecamp.class.should_receive(:get).with('/me.xml').and_return(response)
      @basecamp.user_id.should == 1
    end
  end
end

