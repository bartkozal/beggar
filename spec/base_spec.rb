require 'spec_helper'

describe Beggar::Base do
  before do
    Basecamp.stub(:establish_connection!)
    Basecamp::Person.stub(me: 'x')
    Beggar::CurrentMonth.stub(to_s: 'a')
    Beggar::Hours.stub(to_s: 'b')
    Beggar::Salary.stub(to_s: 'c')
  end

  subject do
    config = double(:[] => { company: 'abc', token: 'xyz', project: { id: 1, rate: 1.0 }})
    Beggar::Base.new(config)
  end

  its(:summary) { should == %(a || b || c) }
  its(:me) { should == 'x' }
end
