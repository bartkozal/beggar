# encoding: utf-8
require 'beggar'

describe Beggar::Base do
  let(:base) { Beggar::Base.new(double('configuration')) }

  it 'returns summary' do
    pending "Output should looks like this: 78% || 140.0h ± 12.0h || $5320.0 ± $456.0"
  end

  describe 'displaying weekdays progression as a percent' do
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
end

