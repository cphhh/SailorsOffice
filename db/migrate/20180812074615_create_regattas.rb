class CreateRegattas < ActiveRecord::Migration[5.1]
  def change
    create_table :regattas do |t|
      t.string :name
      t.string :place
      t.date :startdate
      t.date :enddate

      t.timestamps
    end
  end
end
