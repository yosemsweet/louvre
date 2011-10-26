module KnowsThatObject
	def that(klass)
		that_context[klass.name.to_sym] ||= klass.last
		that_context[klass.name.to_sym] ||= Factory.create(klass.name.downcase.to_sym)
		that_context[klass.name.to_sym]
	end
	
	def set_that(object, klass = nil)
		that_context[klass.present? ? klass.name.to_sym : object.class.name.to_sym] = object
	end
	
	private
	def that_context
		@that_context ||= {}
	end
end

World(KnowsThatObject)