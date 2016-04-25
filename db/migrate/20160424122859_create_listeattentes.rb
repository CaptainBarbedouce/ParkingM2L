class CreateListeattentes < ActiveRecord::Migration
  def change
    create_table :listeattentes do |t|
      t.references :utilisateurs, index: true, foreign_key: true
      t.integer :numPosition, null: false, limit: 3
      t.integer :duration, null: false, limit: 1
    end
  end
end
