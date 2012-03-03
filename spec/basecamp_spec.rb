require 'beggar'

describe Beggar::Basecamp do
  let(:config) { YAML.load_file(File.expand_path('../fixtures/beggar', __FILE__)) }
  let(:basecamp) { Beggar::Basecamp.new(config) }

  before do
    Date.stub(today: Date.new(2012, 02, 17))
  end

  describe 'constructor' do
    after do
      Beggar::Basecamp.new(config)
    end

    it 'set base uri' do
      Beggar::Basecamp.should_receive(:base_uri).with('https://pear.basecamphq.com')
    end

    it 'set basic auth credentials' do
      Beggar::Basecamp.should_receive(:basic_auth).with('abc123', 'X')
    end
  end

  it 'returns user id' do
    response = {'person' => { 'id' => 1 }}
    basecamp.class.should_receive(:get).with('/me.xml').and_return(response)
    basecamp.current_user.should == 1
  end

  it 'returns time report for current user' do
    basecamp.stub(current_user: 1)
    basecamp.class.should_receive(:get).with('/time_entries/report.xml', query: {subject_id: 1})
    basecamp.time_report
  end

  it 'returns time report for current month' do
    basecamp.stub(current_user: 1)
    basecamp.class.should_receive(:get).with('/time_entries/report.xml',
      query: {
        subject_id: 1,
        from: Date.new(2012, 02, 01),
        to: Date.new(2012, 02,17)
      }
    )
    basecamp.current_month
  end

  it 'returns worked hours' do
    response = { "time_entries" =>
      [{ "hours" => 8.0 }, { "hours" => 6.0 }, { "hours" => 8.0 }]
    }
    basecamp.stub(current_month: response)
    basecamp.worked_hours.should == 22.0
  end

  it 'returns 0 when no time entries' do
    response = { "time_entries" => [] }
    basecamp.stub(current_month: response)
    basecamp.worked_hours.should == 0
  end

  it 'returns hours ratio with minus when working hours > weekdays hours' do
    basecamp.stub(worked_hours: 106.0)
    basecamp.hours_ratio.should == -2.0
  end

  it 'returns hours ratio with plus when worked hours < weekdays hours' do
    basecamp.stub(worked_hours: 96.0)
    basecamp.hours_ratio.should == 8.0
  end
end
