# encoding: utf-8
require 'beggar'

describe Beggar::Base do
  let(:basecamp) { double('Basecamp', config: double(rate: 50.0)) }
  let(:base) { Beggar::Base.new(basecamp) }

  describe 'displaying weekdays progression as a percents' do
    it 'returns 62% on 17th February 2012' do
      Date.stub(today: Date.new(2012, 2, 17))
      base.progress.should == "62%"
    end

    it 'returns 9% on 2nd December 2011' do
      Date.stub(today: Date.new(2011, 12, 2))
      base.progress.should == "9%"
    end

    it 'returns 100% on 30th November 1988' do
      Date.stub(today: Date.new(1988, 11, 30))
      base.progress.should == "100%"
    end
  end

  context 'when 4 days have been free in February 2012 and rate is equal $50' do
    before do
      basecamp.stub(worked_hours: 136.0, hours_ratio: 32.0)
    end

    it 'returns "136.0h, -32.0h"' do
      base.worked_hours.should == "136.0h, -32.0h"
    end

    it 'returns "6800.0 zł, -1600.0 zł"' do
      base.salary.should == "6800.0 zł, -1600.0 zł"
    end
  end

  context 'when 1 day has been worked extra in February 2012 and rate is equal $50' do
    before do
      basecamp.stub(worked_hours: 176.0, hours_ratio: -8.0)
    end

    it 'returns "176.0h, +8.0h"' do
      base.worked_hours.should == "176.0h, +8.0h"
    end

    it 'returns "8800.0 zł, +$400.0 zł"' do
      base.salary.should == "8800.0 zł, +400.0 zł"
    end
  end

  describe 'private methods' do
    it 'returns formatted ratio' do
      base.send(:ratio, 1.0).should == "-1.0"
      base.send(:ratio, -3.0).should == "+3.0"
    end

    it 'returns hours multiplied by rate' do
      basecamp.stub_chain(:config, :rate).and_return(50.0)
      base.send(:as_money, 5.0).should == 250.0
    end
  end

  it 'returns summary' do
    base.stub(progress: "78%", worked_hours: "140.0h, -12.0h", salary: "5320.0 zł, -456.0 zł")
    base.summary.should == "78% || 140.0h, -12.0h || 5320.0 zł, -456.0 zł"
  end
end

