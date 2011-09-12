require 'spec_helper'

describe Role do
  
  describe "#==" do
    let(:left) {Role.new("user")}

    context "compared with a symbol" do
      context "that is the same as the role's name" do
        it "should return true" do
          (left == :user).should be_true
        end
      end
    end
  end
  
  describe "#<=>" do
    
      before(:each) do
        # Make these the actual object.
        @role = Role.new("visitor")
        @roles_to_compare = [
          :visitor,
          :user,
          :member,
          :owner,
          :admin
        ]
      end
    
      it "should return 1 for a less powerful role" do
        @roles_to_compare.split(@role).first.each do |role_to_compare|
          (@role <=> role_to_compare).should == 1
        end
      end
      
      it "should return 0 for the same role" do
          (@role <=> :visitor).should == 0
      end
      
      it "should return -1 for a more powerful role" do
        @roles_to_compare.split(@role).last.each do |role_to_compare|
          (@role <=> role_to_compare).should == -1
        end
      end
    
  end

end
