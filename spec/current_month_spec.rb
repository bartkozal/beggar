require 'beggar'

describe Beggar::CurrentMonth do
  let(:current_month) { Beggar::CurrentMonth }

  before do
    Date.stub(today: Date.new(2012, 2, 17))
  end

  it 'returns weekdays in hours' do
    current_month.weekday_hours.should == 168.0
  end
end

