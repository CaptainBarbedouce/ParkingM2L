class CreatePlaceparkings < ActiveRecord::Migration
  def change
    create_table :placeparkings do |t|

      t.timestamps null: false
    end
  end
end
