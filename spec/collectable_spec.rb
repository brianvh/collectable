require 'spec_helper'

describe "Using Collectable on the Parent class" do
  context "collecting into a :children group" do
    before(:each) do
      Parent.instance_eval do
        include Collectable
        collectable :into => :children
      end
      @parent = Parent.new
    end

    it "stores :children as the collectable group" do
      @parent.class.collectable_options[:group].should == :children
    end
  end
end