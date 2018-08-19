class CreateBalances < ActiveRecord::Migration[5.1]
  def change
    create_table :balances do |t|
      t.integer :regatta_id
      t.boolean :closed
      t.date :closing_date

      t.timestamps
    end
  end
end
