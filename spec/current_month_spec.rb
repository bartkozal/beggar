require 'beggar'

describe Beggar::CurrentMonth do
  let(:current_month) { Beggar::CurrentMonth }

  before do
    Date.stub(today: Date.new(2012, 2, 17))
  end

  it 'returns weekdays' do
    pending
  end

  it 'returns weekdays until today' do
    pending
  end

  it 'returns weekdays in hours' do
    current_month.weekday_hours.should == 168.0
  end

  it 'returns weekdays in hours until today' do
    current_month.weekday_hours_until_today.should == 104.0
  end

  it 'returns weekdays progression' do
    pending
  end

  it 'returns weekdays until date' do
    pending
  end

  it 'returns first day of month' do
    pending
  end

  it 'returns last day of month' do
    pending
  end

  it 'returns year' do
    pending
  end

  it 'returns month' do
    pending
  end

  it 'returns today' do
    pending
  end
end

