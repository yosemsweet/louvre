require 'spec_helper'

describe "canvae/edit.html.haml" do
  before(:each) do
    @canvas = Factory.create(:canvas)
  end
  
  before do
     controller.singleton_class.class_eval do
       private
         def current_user
           nil
         end
         helper_method :current_user
     end
   end
end