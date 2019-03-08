class AddFieldsToRegatta < ActiveRecord::Migration[5.1]
  def change
    add_column :regattas, :registration_deadline, :date
    add_column :regattas, :registrated, :boolean, default: false
    add_column :regattas, :early_entry_deadline, :date
    add_column :regattas, :paid, :boolean, default: false
    add_column :regattas, :comment, :string
  end
end
