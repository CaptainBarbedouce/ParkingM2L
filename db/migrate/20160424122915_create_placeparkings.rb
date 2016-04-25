class CreatePlaceparkings < ActiveRecord::Migration
  def change
    create_table :placeparkings do |t|
      t.string :libel, null: false, limit: 2
      t.boolean :occupied, null: false, default: false
    end
  end
end
