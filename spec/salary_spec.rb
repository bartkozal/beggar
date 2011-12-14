# encoding: utf-8

require 'spec_helper'

describe 'Beggar::Salary' do
  context 'user was working 10h (max: 40h) in current month and his rate per h amount 100.0 PLN' do
    before do
      Beggar::Hours.stub(from_basecamp: 10, up_today: 40)
      Beggar::Salary.stub(rate: 100.0)
    end

    subject { Beggar::Salary }

    its(:from_basecamp) { should == 1000.0 }
    its(:up_today) { should == 4000.0 }
    its(:difference) { should == 3000.0 }
    its(:to_s) { should == '1000.0 PLN ± 3000.0 PLN' }
  end
end
