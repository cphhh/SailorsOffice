class RenameRegattasUsersTmps < ActiveRecord::Migration[5.1]
  def change
    rename_table :regattas_users_tmps, :regatta_users
  end
end
