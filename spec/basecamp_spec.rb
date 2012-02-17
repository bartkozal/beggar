require 'beggar'

describe Beggar::Basecamp do
  let(:config) { YAML.load_file(File.expand_path('../fixtures/beggar', __FILE__)) }
  let(:basecamp) { Beggar::Basecamp.new(config) }

  describe 'constructor' do
    after do
      Beggar::Basecamp.new(config)
    end

    it 'set base uri' do
      Beggar::Basecamp.should_receive(:base_uri).with('https://Apple.basecamphq.com')
    end

    it 'set basic auth credentials' do
      Beggar::Basecamp.should_receive(:basic_auth).with('abc123', 'X')
    end
  end

  it 'returns user id' do
    response = { 'person' => { 'id' => 1 }}
    basecamp.class.should_receive(:get).with('/me.xml').and_return(response)
    basecamp.current_user.should == 1
  end

  it 'returns array with project ids' do
    response = { "projects" =>
      [
        { "id" => 1, "status" => "active" },
        { "id" => 2, "status" => "on_hold" },
        { "id" => 4, "status" => "archived" },
        { "id" => 3, "status" => "active" }
      ]
    }
    basecamp.class.should_receive(:get).with('/projects.xml').and_return(response)
    basecamp.projects.should == [1, 3]
  end

  it 'returns time report for current user' do
    basecamp.stub(current_user: 1)
    basecamp.class.should_receive(:get).with('/time_entries/report.xml?subject_id=1')
    basecamp.time_report
  end

  describe 'private methods' do
    it 'parses options to path params' do
      basecamp.send(:params, { name: 'bob'}).should == '?name=bob'
      basecamp.send(:params, { name: 'bob', surname: 'example'}).should == '?name=bob&surname=example'
    end
  end
end

