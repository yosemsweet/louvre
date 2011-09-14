require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  
  before(:each) do
    @user = Factory.create(:user)
    @ability = Ability.new(@user)
  end
  
  context "for a page" do

    before(:each) do
      @canvas = Factory.create(:canvas)
    end
    
    it "should not allow users to update" do
      @ability.should_not be_able_to(:update, Factory.build(:page, :canvas => @canvas))
    end
    
    it "should allow members to update" do
      @user.set_canvas_role(@canvas, :member)
      @ability.should be_able_to(:update, Factory.build(:page, :canvas => @canvas))
    end
  
  end
  
end