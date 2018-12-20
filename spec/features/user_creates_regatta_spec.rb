require "rails_helper"

feature "User creates regatta" do
	scenario "successfully" do
		create_regatta
		visit regattas_path
		expect(page).to have_css 'td', text: 'Testregatta'   
	end
end
