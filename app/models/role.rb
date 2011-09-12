class Role

  def initialize(name)
    @name = name.to_sym
  end
  
  include Comparable
  
  def power
    ROLES[@name] || 0
  end
  
  def <=>(other_role_name)  
    power <=> Role.new(other_role_name).power
  end
  

end
