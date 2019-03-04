class CreateDeposits < ActiveRecord::Migration[5.1]
  def change
    create_table :deposits do |t|
      t.float :amount
      t.date :date
      t.integer :user_id

      t.timestamps
    end
  end
end
