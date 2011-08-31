class Email < ActiveRecord::Base
    
  validates :address, :presence => true
  
  belongs_to :user
  
  def primary_address?
    primary == 1
  end
  
end
