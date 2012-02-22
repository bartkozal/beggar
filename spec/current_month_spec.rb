require 'beggar'

describe Beggar::CurrentMonth do
  let(:current_month) { Beggar::CurrentMonth }

  before do
    Date.stub(today: Date.new(2012, 2, 17))
  end

  it 'returns weekdays' do
    current_month.weekdays.should == 21
  end

  it 'returns weekdays until today' do
    current_month.weekdays_until_today.should == 13
  end

  it 'returns weekdays in hours' do
    current_month.weekday_hours.should == 168.0
  end

  it 'returns weekdays in hours until today' do
    current_month.weekday_hours_until_today.should == 104.0
  end

  it 'returns weekdays progression' do
    current_month.weekdays_progression.should == 62
  end

  it 'returns weekdays until date' do
    date = Date.new(2012, 2, 23)
    current_month.weekdays_until(date).should == 17
  end

  it 'returns first day of month' do
    current_month.first_day.should == Date.new(2012, 2, 1)
  end

  it 'returns last day of month' do
    current_month.last_day.should == Date.new(2012, 2, 29)
  end

  it 'returns year' do
    current_month.year.should == 2012
  end

  it 'returns month' do
    current_month.month.should == 2
  end

  it 'returns today' do
    current_month.today.should == Date.new(2012, 2, 17)
  end
end

