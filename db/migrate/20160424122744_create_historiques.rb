class CreateHistoriques < ActiveRecord::Migration
  def change
    create_table :historiques do |t|
	  t.references :utilisateurs, index: true, foreign_key: true
      t.references :placeparkings, index: true, foreign_key: true
      t.datetime :date_debut, null: false
      t.datetime :date_fin, null: false
    end
  end
end
