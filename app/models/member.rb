class Member < ActiveRecord::Base
	def self.search(query)
		rel = order(:number)
		if query.present?
			rel = rel.where("name LIKE ? OR full_name LIKE ?", "%#{query}", "%#{query}")
		end 
		rel
	end 
end
