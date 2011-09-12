class Role

  def initialize(name)
    @name = name
  end
  
  include Comparable
  
  def power
    ROLES[@name.to_sym] || 0
  end
  
  def <=>(other_role_sym)  
    power <=> ROLES[other_role_sym]
  end

end
