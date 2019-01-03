class AddRatesToRegattas < ActiveRecord::Migration[5.1]
  def change
    add_column :regattas, :supplement, :float
    add_column :regattas, :fee, :float
  end
end
