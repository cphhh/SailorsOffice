require 'rails_helper'

RSpec.describe Regatta, :type => :model do
  subject { described_class.new }

	it "is valid with valid attributes" do
		subject.name = "Herbsregatta"
		subject.startdate = Date.today
		subject.enddate = Date.today + 1.day
		subject.fee = "5,00"
		subject.supplement = "5,00"
		expect(subject).to be_valid
	end

	it "is not valid without a name" do
		expect(subject).not_to be_valid
	end

	it "is not valid without a startdate" do
		subject.name = "Herbstregatta"
		expect(subject).not_to be_valid
	end

	it "is not valid without a enddate" do
		subject.name = "Herbstregatta"
		subject.startdate = DateTime.now
		expect(subject).not_to be_valid
	end

	it "is not valid without a supplement" do
		subject.name = "Herbstregatta"
		subject.startdate = DateTime.now
		subject.enddate = DateTime.now + 1.day
		expect(subject).not_to be_valid
	end

	it "is not valid without a fee" do
		subject.name = "Herbstregatta"
		subject.startdate = DateTime.now
		subject.enddate = DateTime.now + 1.day
		subject.supplement = "5,00"
		expect(subject).not_to be_valid
	end
	
	it "is not valid if startdate is before enddate" do
		subject.name = "Herbstregatta"
		subject.startdate = DateTime.now + 1.day
		subject.enddate = DateTime.now
		subject.supplement = "5,00"
		subject.fee = "5,00"
		expect(subject).not_to be_valid
	end
	

end

