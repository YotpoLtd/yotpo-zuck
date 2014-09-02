require 'spec_helper'

class HDTest
  include Zuck::HashDelegator
  fields :bar
end

describe Zuck::HashDelegator do

  let(:del){ HDTest.new }

  it "assigns a value" do
    del[:foo] = :bar
    del[:foo].should == :bar
  end

  it "has a shortcut getter" do
    del[:foo] = :bar
    del.data.should == {foo: :bar}
  end

  it "transforms keys to symbols" do
    del['bar'] = :foo
    del['bar'].should == :foo
    del[:bar].should == :foo
  end

  it "becomes a pretty string" do
    x = HDTest.new
    x[:some] = "thing"
    x[:bar]  = 1
    x.to_s.should == '#<HDTest some: "thing", bar: 1>'
  end

  it "allows to assign a hash" do
    x = HDTest.new
    x.set_data('some' => "thing", bar: 1)
    x.to_s.should == '#<HDTest some: "thing", bar: 1>'
    x[:some].should == "thing"
  end

  it "allows to assign a hash using a shortcut" do
    x = HDTest.new
    x.data = {'some' => "thing", bar: 1}
    x.to_s.should == '#<HDTest some: "thing", bar: 1>'
    x[:some].should == "thing"
  end

  it "has methods defined for the known keys" do
    del[:bar] = :foo
    del.bar.should == :foo
  end

end
