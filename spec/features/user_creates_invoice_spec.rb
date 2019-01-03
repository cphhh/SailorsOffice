require "rails_helper"

feature "User creates invoice" do
	scenario "successfully" do
		create_user
		visit root_path
		sign_in
		create_regatta "Testregatta", "Hamburg", "2018/06/25", "2018/06/30", "5,0", "5"
		create_invoice "Diesel", "50,00"
		find('#allinvoices').click
		expect(page).to have_css 'td', text: 'Diesel'   
	end
end
