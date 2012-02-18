require 'beggar'

# FIXME add missing specs
describe Beggar::CurrentMonth do
  let(:current_month) { Beggar::CurrentMonth }

  before do
    Date.stub(today: Date.new(2012, 2, 17))
  end

  it 'returns weekdays in hours' do
    current_month.weekday_hours.should == 168.0
  end

  it 'returns weekdays in hours until today' do
    current_month.weekday_hours_until_today.should == 104.0
  end
end

