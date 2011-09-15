class Role

  def initialize(name)
    @name = name.to_sym
  end
  
  include Comparable
  
  def power
    ROLES[@name] || 0
  end
  
  def <=>(other_role_name)  
		if other_role_name.respond_to?(:power)
			right = other_role_name
		else
			right = Role.new(other_role_name)
		end
    power <=> right.power
  end
  

end
