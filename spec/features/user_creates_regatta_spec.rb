require "rails_helper"

feature "User creates regatta" do
	scenario "successfully" do
		create_user
		sign_in
		create_regatta
		visit regattas_path
		expect(page).to have_css 'td', text: 'Testregatta'   
		visit balances_path
		expect(page).to have_css 'td', text: 'Testregatta'   
	end
end
