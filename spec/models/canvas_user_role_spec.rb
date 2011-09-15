require 'spec_helper'

describe CanvasUserRole do
	
	context "attributes" do
		let(:canvas_user_role) { Factory.build(:canvas_user_role) }
		
		it "should have a canvas" do
			canvas_user_role.should respond_to(:canvas)
		end
				
		it "should have a user" do
			canvas_user_role.should respond_to(:user)
		end
		
		it "should have a role" do
			canvas_user_role.should respond_to(:role)
		end
	end
	
	context "scopes" do
		let(:member_role) { Factory.create(:canvas_user_role, :role => :member) }
		let(:owner_role) { Factory.create(:canvas_user_role, :role => :owner) }
		let(:banned_role) { Factory.create(:canvas_user_role, :role => :banned) }

		context "banned" do
			it "should exist" do
				CanvasUserRole.should respond_to(:banned)
			end
			
			it "should return canvas_user_roles with the :banned role" do
				CanvasUserRole.banned.should include(banned_role)
			end
			
			it "should not return any roles other than :banned" do
				CanvasUserRole.banned.where("role <> :role", :role => :banned).should be_empty
			end
		end
		
		context "not_banned" do
			it "should exist" do
				CanvasUserRole.should respond_to(:not_banned)
			end
			
			it "should not return canvas_user_roles with the :banned role" do
				CanvasUserRole.not_banned.where("role = :role", :role => :banned).should be_empty
			end
			
			it "should return any roles other than :banned" do
				CanvasUserRole.where("role <> :role", :role => :banned).each do |role|
					CanvasUserRole.not_banned.should include(role)
				end
			end
		end

		context "members" do
			it "should exist" do
				CanvasUserRole.should respond_to(:members)
			end
			
			it "should return canvas_user_roles with the :members role" do
				CanvasUserRole.members.should include(member_role)
			end
			
			it "should not return any roles other than :banned" do
				CanvasUserRole.members.where("role <> :role", :role => :member).should be_empty
			end
		end
		
	end
	
end