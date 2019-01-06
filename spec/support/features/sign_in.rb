module Features
	def sign_in(email, password)
		visit root_path
		fill_in "inputEmail", with: email
		fill_in "inputPassword", with: password
		click_on "Log in"
	end

	def create_user(email, password, name) 
		@user = User.create(email: email, password: password, name: name)
		@user.save
	end
end
