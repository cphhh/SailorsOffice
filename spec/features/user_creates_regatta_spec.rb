require "rails_helper"

feature "User creates regatta" do
	scenario "successfully" do
		create_user "user1@admin.com", "password", "User1"
		sign_in "user1@admin.com", "password"
		create_regatta "Testregatta", "Hamburg", "2018/06/25", "2018/06/30", "5", "5,00"
		visit regattas_path
		expect(page).to have_css 'td', text: 'Testregatta'   
		visit balances_path
		expect(page).to have_css 'td', text: 'Testregatta'   
	end
end
