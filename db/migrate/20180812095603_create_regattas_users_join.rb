class CreateRegattasUsersJoin < ActiveRecord::Migration[5.1]
  def change
    create_table 'regattas_users', :id => false do |t|
      t.column 'regatta_id', :integer
      t.column 'user_id', :integer
    end
  end
end
