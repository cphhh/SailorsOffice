require "rails_helper"

feature "User views balance" do
	scenario "successfully" do
		create_user
		sign_in
		create_regatta "Testregatta", "Hamburg", "2018/06/25", "2018/06/30", "5,00", "5"
		join_regatta
		create_invoice "Diesel", "50,00"

		find('#allbalances').click
		find('tbody').find(:xpath, ".//a[i[contains(@class, 'fe fe-eye')]]").click

		expect(page).to have_css 'h1', text: 'Balance for Testregatta'
		td = page.find(:css, 'td', text: 'Subtotal') # find the id td with text of exactly 22
		tr = td.find(:xpath, './parent::tr') # get the parent tr of the td
		expect(tr).to have_css('td', text: '50.0')

		td = page.find(:css, 'td', text: 'Total Costs') # find the id td with text of exactly 22
		tr = td.find(:xpath, './parent::tr') # get the parent tr of the td
		expect(tr).to have_css('td', text: '82.5')
	end
end
