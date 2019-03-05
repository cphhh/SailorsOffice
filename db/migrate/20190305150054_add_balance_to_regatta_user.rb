class AddBalanceToRegattaUser < ActiveRecord::Migration[5.1]
  def change
    add_column :regatta_users, :balance, :float
  end
end
