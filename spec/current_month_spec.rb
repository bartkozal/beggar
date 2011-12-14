require 'spec_helper'

describe Beggar::CurrentMonth do
  context 'today is the 24th December 2011' do
    before(:all) { Timecop.travel(Date.new(2011, 12, 24)) }
    after(:all) { Timecop.return }

    subject { Beggar::CurrentMonth }

    its(:first_day) { should == Date.new(2011, 12, 1) }
    its(:last_day) { should == Date.new(2011, 12, 31) }
    its(:working_days) { should == 22 }
    its(:working_days_up_today) { should == 17 }
    its(:to_s) { should == '77%' }
  end
end
