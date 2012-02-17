# encoding: utf-8
require 'beggar'

describe Beggar::Base do
  let(:base) { Beggar::Base.new(double('configuration')) }

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

  describe 'displaying worked hours' do
    before do
      Date.stub(today: Date.new(2012, 2, 17))
    end

    it 'returns "136.0h, -32.0h" when 4 days have been free in February 2012' do
      base.worked_hours.should == "136.0h, -32.0h"
    end

    it 'returns "176.0h, +8.0h" when 1 day has been worked extra in February 2012' do
      base.worked_hours.should == "176.0h, +8.0h"
    end
  end
end

