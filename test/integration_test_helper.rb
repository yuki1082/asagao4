module IntegrationTestHelper
	private
	def login_as(name, admin = false)
		member = FactoryGirl.create(:member, name: name,  administrator: false)
		post "/session", name: member.name, password: member.password
	end 

	def logout
		delete "/session"
	end 
end 