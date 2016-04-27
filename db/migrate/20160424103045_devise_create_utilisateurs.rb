class DeviseCreateUtilisateurs < ActiveRecord::Migration
  def change
    create_table :utilisateurs do |t|
      t.string :nom, limit: 25, null: false
      t.string :prenom, limit: 25, null: false
      t.string :adresse, limit: 50
      t.string :cp, limit: 5
      t.string :ville, limit: 50
      t.string :tel, limit: 10, null: false
      t.boolean :compte_accepted, default: false, null: false
      t.boolean :demande_reservation, default: false, null: false
      t.boolean :reservation_automatique, default: false, null: false
      t.boolean :admin, default: false
      t.references :ligues, index: true, foreign_key: true

      ## Database authenticatable
      t.string :email,              null: false
      t.string :encrypted_password, null: false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
       t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at
    end

    add_index :utilisateurs, :email,                unique: true
    add_index :utilisateurs, :reset_password_token, unique: true
    add_index :utilisateurs, :confirmation_token,   unique: true
    # add_index :utilisateurs, :unlock_token,         unique: true
  end
end
