require "rails_helper"

feature "User creates invoice" do
	scenario "successfully" do
		visit root_path
		create_user
		sign_in
		click_on "All regattas"
		#find(:css, 'i.fa.fa-eye.fa-lg').click
		expect(page).to have_css 'h1', text: 'All regattas'   
	end
end
