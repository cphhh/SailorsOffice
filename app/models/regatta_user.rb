class RegattaUser < ApplicationRecord
	validates_presence_of :regatta, :user

	belongs_to :user
	belongs_to :regatta
end
