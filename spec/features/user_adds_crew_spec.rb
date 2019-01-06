require "rails_helper"
feature "User adds crew" do
	scenario "successfully" do
		create_user "user1@admin.com", "password", "User1"
		create_user "user2@admin.com", "password", "User2"
		sign_in "user1@admin.com", "password"

		create_regatta "Testregatta", "Hamburg", "2018/06/25", "2018/06/30", "5,00", "5"

		find('#joinregattas').click
		thead = page.find(:css, 'thead')
		expect(thead).to have_css('th', text: 'User1')
		expect(thead).to have_css('th', text: 'User2')

		user1regatta = page.find(:xpath, "//table/tbody/"\
																		 "tr[contains(*/td/text(),'Testregatta')]//"\
																		 "td[count(//table/thead/tr/th[.='User1']/preceding-sibling::th)+1]/input")
		user2regatta = page.find(:xpath, "//table/tbody/"\
 																		 "tr[contains(*/td/text(),'Testregatta')]//"\
 																		 "td[count(//table/thead/tr/th[.='User2']/preceding-sibling::th)+1]/input")
		expect(user1regatta.checked?).to be == false
		expect(user2regatta.checked?).to be == false

		user1regatta.set(true)
		click_on "Save"
		expect(user1regatta.checked?).to be == true

		user1regatta.set(false)
		click_on "Save"
		expect(user1regatta.checked?).to be == false

		user2regatta.set(true)
		click_on "Save"
		expect(user2regatta.checked?).to be == true

		find('#joinregattas').click
		expect(user1regatta.checked?).to be == false
		expect(user2regatta.checked?).to be == true
	end
end
