class Invoice < ApplicationRecord
  belongs_to :regatta
  belongs_to :user
end
