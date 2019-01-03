class CreateRegattasUsersTmps < ActiveRecord::Migration[5.1]
  def change
    create_table :regattas_users_tmps do |t|
			t.belongs_to :regatta, :null => false, :index => true
			t.belongs_to :user, :null => false, :index => true
    end
  end
end
