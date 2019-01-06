module Features
	def within_column(column)
  	within(:xpath, "//table/tbody/tr/td[count(//table/thead/tr/th[normalize-space()='#{column}']/preceding-sibling::th)+1]") do
  	  yield
  	end
	end

	def within_row(name)
  	within(:xpath, "//tr[td='#{name}']") { yield }
	end

	def within_cell(row, column)
	  within_row(row) do
	    within_column(column) { yield }
	  end
	end
end
