# encoding: utf-8
require 'spec_helper'

describe Beggar::CLI do
  before do
    @cli = Beggar::CLI.new 
  end

  it "should returns summary with salary on start" do
    @cli.start.should == "00% || 00.0h ± 00.0h || 00.0 PLN ± 00.0 PLN"
  end
end
