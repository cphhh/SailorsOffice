module Features
	def create_regatta	
		find('#newregatta').click
	  fill_in "regatta_name", with: "Testregatta"
		fill_in "regatta_place", with: "Hamburg"
		fill_in "regatta_startdate", with: "2018/06/25"	
		fill_in "regatta_enddate", with: "2018/06/30"	
		click_on "Create regatta"
	end
end
