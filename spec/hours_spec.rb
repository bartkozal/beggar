# encoding: utf-8

require 'spec_helper'

describe 'Beggar::Hours' do
  context 'user was working in current month 2 days (8h and 6h)' do
    before do
      api_response = double(map: [8.0, 6.0])
      Basecamp::TimeEntry.stub(report: api_response)
      Beggar::CurrentMonth.stub(working_days_up_today: 2)
    end

    subject { Beggar::Hours }

    its(:from_basecamp) { should == 14.0 }
    its(:up_today) { should == 16.0 }
    its(:difference) { should == 2.0 }
    its(:to_s) { should == '14.0h ± 2.0h' }
  end
end
