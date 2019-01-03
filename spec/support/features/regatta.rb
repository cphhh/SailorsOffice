module Features
	def create_regatta(name, place, startdate, enddate, fee, supplement)	
		find('#newregatta').click
	  fill_in "regatta_name", with: name
		fill_in "regatta_place", with: place
		fill_in "regatta_startdate", with: startdate
		fill_in "regatta_enddate", with: enddate
		fill_in "regatta_supplement", with: supplement
		fill_in "regatta_fee", with: fee
		click_on "Create regatta"
	end
end
