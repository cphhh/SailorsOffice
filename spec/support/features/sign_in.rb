module Features
	def sign_in
		visit root_path
		fill_in "inputEmail", with: "peter@example.com"
		fill_in "inputPassword", with: "Password"
		click_on "Log in"
	end

	def create_user 
		@user = User.create(email: "peter@example.com", password: "Password", name: "Peter")
		@user.save
	end
end
