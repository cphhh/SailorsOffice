require "rails_helper"

feature "User signs in" do
	scenario "successfully" do
		create_user "user1@admin.com", "password", "User1"
		sign_in "user1@admin.com", "password"
		expect(page).to have_css 'h2', text: 'Current Regattas'   
	end
end
