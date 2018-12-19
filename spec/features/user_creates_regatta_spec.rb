require "rails_helper"

feature "User creates regatta" do
	scenario "successfully" do
		visit root_path
		create_user
		sign_in
		find('#newregatta').click
	  fill_in "regatta_name", with: "Testregatta"
		fill_in "regatta_place", with: "Hamburg"
		fill_in "regatta_startdate", with: "2018/06/25"	
		fill_in "regatta_enddate", with: "2018/06/30"	
		click_on "Create regatta"
		visit regattas_path
		expect(page).to have_css 'td', text: 'Testregatta'   
	end
end
