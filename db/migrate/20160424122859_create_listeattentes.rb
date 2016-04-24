class CreateListeattentes < ActiveRecord::Migration
  def change
    create_table :listeattentes do |t|

      t.timestamps null: false
    end
  end
end
