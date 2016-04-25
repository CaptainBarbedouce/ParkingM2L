class Parkingduration < ActiveRecord::Migration
  def change
  	create_table :parkingduration do |t|
  	  t.integer :maxduration, default: 3, null: false
    end
  end
end
