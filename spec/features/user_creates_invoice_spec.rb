require "rails_helper"

feature "User creates invoice" do
	scenario "successfully" do
		#visit root_path
		create_user
		sign_in
	end
end
