class Regatta < ApplicationRecord
	has_many :regatta_users
	has_many :users, :through => :regatta_users

  has_many :invoices
  has_one :balance

	before_save {self.name = name.capitalize}
	validates :name, presence: true
	validates :startdate, presence: true
	validates :enddate, presence: true
	validates :supplement, presence: true
	validates :fee, presence: true
	validate :enddate_after_startdate

	def enddate_after_startdate
	  if enddate.present? && startdate.present? && enddate < startdate
  	  errors.add(:enddate, "must be after start date")
  	end
	end
end
