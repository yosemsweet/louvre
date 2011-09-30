class Randexp::Dictionary
end

Randexp::Dictionary.class_eval {
	class << self
		alias_method :old_load_dictionary, :load_dictionary
	end
	
  def self.load_dictionary
    if File.exists?(::Rails.root.to_s + "/config/words")
			File.read(::Rails.root.to_s + "/config/words").split
		else
			"foo bar crud".split
		end
  end
	
	def self.foo
	end
}


