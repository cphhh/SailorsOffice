class AddFieldsToRegattaUser < ActiveRecord::Migration[5.1]
  def change
    add_column :regatta_users, :costs, :float
    add_column :regatta_users, :fee, :float
    add_column :regatta_users, :supplement, :float
    add_column :regatta_users, :expenses, :float
  end
end
