require 'spec_helper'

describe 'DateHelper' do
	describe '#show_date' do
		
		it "should respond to show_date" do
			helper.should respond_to(:show_date)
		end
		
		it "should accept 1 argument" do
			helper.should respond_to(:show_date).with(1).argument
		end
		
		context "with a date time" do
			
			before(:each) do
				@date = Time.new
			end
			
			it "should return an html safe string containing a time tag" do
				helper.show_date(@date).should be_kind_of(String)
				helper.show_date(@date).should be_html_safe
				helper.show_date(@date).should have_selector("time")
			end
			
		end
		
		context "time is within last week" do
			
			#TODO use timecop here to lock down the time so we can test the boundary condition
			before(:each) do
				@now = Time.now
				@a_week_ago = 6.days.ago
			end
			
			it "should display the time in words" do
				helper.show_date(@now).should include(time_ago_in_words(@now))
				helper.show_date(@a_week_ago).should include(time_ago_in_words(@a_week_ago))
			end
			
		end
		
		context "time is more than a week ago" do
			
			#TODO use timecop here to lock down the time so we can test the boundary condition
			before(:each) do
				@a_week_ago_and_a_bit = 8.days.ago
			end
			
			it "should display the time as a date" do
				helper.show_date(@a_week_ago_and_a_bit).should include(@a_week_ago_and_a_bit.strftime("%b %d %Y %I:%M %p"))
			end
			
		end
	end
end