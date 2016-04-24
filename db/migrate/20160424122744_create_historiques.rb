class CreateHistoriques < ActiveRecord::Migration
  def change
    create_table :historiques do |t|

      t.timestamps null: false
    end
  end
end
