require 'beggar'

describe Beggar::CurrentMonth do
  let(:current_month) { Beggar::CurrentMonth.new(:country => 'pl') }

  before do
    Date.stub(today: Date.new(2012, 2, 17))
  end

  it 'returns workdays' do
    current_month.workdays.should == 21
  end

  it 'returns workdays until today' do
    current_month.workdays_until_today.should == 13
  end

  it 'returns workdays in hours' do
    current_month.workday_hours.should == 168.0
  end

  it 'returns workdays in hours until today' do
    current_month.workday_hours_until_today.should == 104.0
  end

  it 'returns workdays progression' do
    current_month.workdays_progression.should == 62
  end

  it 'returns workdays until date' do
    date = Date.new(2012, 2, 23)
    current_month.workdays_until(date).should == 17
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

