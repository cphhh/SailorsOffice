require "rails_helper"

feature "User creates invoice" do
	scenario "successfully" do
		create_user
		visit root_path
		sign_in
		create_regatta
		create_invoice "Diesel"
		find('#allinvoices').click
		expect(page).to have_css 'td', text: 'Diesel'   
	end
end
