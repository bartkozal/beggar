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

  describe '#projects' do
    it 'returns array of projects' do
      response = { "projects" =>
                   [
                     { "id" => 1, "status" => "active" },
                     { "id" => 2, "status" => "on_hold" },
                     { "id" => 4, "status" => "archived" },
                     { "id" => 3, "status" => "active" }
                   ]
      }
      @basecamp.class.should_receive(:get).with('/projects.xml').and_return(response)
      @basecamp.projects.should == [1, 3]
    end
  end

  describe '#report' do
    it 'returns time report for specific user' do
      @basecamp.stub(user_id: 1)
      @basecamp.class.should_receive(:get).with('/time_entries/report.xml?subject_id=1')
      @basecamp.report
    end
  end

  describe '#parse_headers' do
    it 'parses options for url' do
      @basecamp.parse_headers(name: 'bob').should == '?name=bob'
      @basecamp.parse_headers(name: 'bob', surname: 'example').should == '?name=bob&surname=example'
    end
  end
end

