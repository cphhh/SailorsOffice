class CopyRegattasUsers < ActiveRecord::Migration[5.1]
  class User < ApplicationRecord
    has_and_belongs_to_many :regattas
    has_many :regattas_users_tmps
    has_many :regattas_tmp, :through => :regattas_users_tmps, :source => :regatta
  end

  class Regatta < ApplicationRecord
    has_and_belongs_to_many :users
    has_many :regattas_users_tmps
    has_many :users_tmp, :through => :regattas_users_tmps, :source => :user
  end

  class RegattasUsersTmp < ApplicationRecord
    belongs_to :regatta
    belongs_to :user
  end

  def up
    Regatta.find_each do |regatta|
      regatta.users_tmp = regatta.users
    end
  end

  def down
	end
end
