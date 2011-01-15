require 'spec_helper'

describe "Using Collectable on the Parent class" do
  before(:all) do
    Parent.instance_eval { include Collectable }
  end

  context "collecting into a :children group" do
    before(:all) do
      Parent.instance_eval { collectable :into => :children }
    end

    before(:each) do
      @parent = Parent.new
    end

    it "stores :children as the collectable group label" do
      @parent.class.collectable_options[:group].should == :children
    end

    it "stores :child as the collectable singular label" do
      @parent.class.collectable_options[:single].should == 'child'
    end

    it "has not loaded the subclasses, with no :from option" do
      @parent.class.children.should == {}
    end
  end

  context "collecting into :children and loading subclasses" do
    before(:all) do
      Parent.instance_eval { collectable :into => :children, 
        :from => File.expand_path('../support/children', __FILE__) }
    end

    before(:each) do
      @parent = Parent.new
    end

    it "has loaded 2 subclasses" do
      @parent.class.children.should have(2).items
    end

    it "returns the One class when asked for :one" do
      @parent.class.children[:one].should == One
    end
  end
end