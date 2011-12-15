require 'spec_helper'

describe Beggar::CurrentMonth do
  context 'today is the 24th December 2011' do
    before { Date.stub(today: Date.new(2011, 12, 24)) }

    let(:first_day) { Date.new(2011, 12, 1) }
    let(:last_day) { Date.new(2011, 12, 31) }

    subject { Beggar::CurrentMonth }

    its(:first_day) { should == first_day }
    its(:last_day) { should == last_day }
    it { subject.working_days(first_day..last_day).should == 22 }
    its(:working_days_up_today) { should == 17 }
    its(:to_s) { should == '77%' }
  end
end
