module HtmlMatcherHelpers
	def has_html?(html, scope = nil)
		scope ||= page.find("body")
				
		fragment = Nokogiri::HTML(html)
		fragment.xpath("//body").children.each do |node|
			selector = node.name
			node.attributes.each do |name, attr|
				selector+= "[#{name}='#{attr.inner_text}']"
			end

			scope.should have_selector(selector)
			
			if node.elements.size
				node.elements.each do |child|
					has_html?(child.to_html, scope.find(selector))
				end
			end
			
		end
	end
end


World(HtmlMatcherHelpers)