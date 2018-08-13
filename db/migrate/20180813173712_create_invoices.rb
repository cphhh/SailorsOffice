class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.string :name
      t.float :price
      t.string :comment
      t.integer :user_id
      t.integer :regatta_id

      t.timestamps
    end
  end
end
