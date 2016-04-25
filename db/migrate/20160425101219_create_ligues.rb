class CreateLigues < ActiveRecord::Migration
  def change
    create_table :ligues do |t|
      t.string :libel, limit: 50, null: false
    end
  end
end
