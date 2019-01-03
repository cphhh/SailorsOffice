class DropRegattasUsers < ActiveRecord::Migration[5.1]
  def change
		drop_table :regattas_users
  end
end
