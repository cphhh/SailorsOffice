module Features
	def create_invoice(name, price)
		find('#allregattas').click
		find('tbody').find(:xpath, ".//a[i[contains(@class, 'fe fe-plus')]]").click
		fill_in 'Name', with: name
		fill_in 'Price', with: price
		fill_in 'Comment', with: 'Volltanken in Hamburg'
		click_on('Create invoice')
	end
end
