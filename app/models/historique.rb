class Historique < ActiveRecord::Base
  belongs_to :utilisateur, :class_name => "Utilisateur", :foreign_key => "utilisateurs_id"
  belongs_to :placeparking, :class_name => "Placeparking", :foreign_key => "placeparkings_id"

  validates :date_debut, presence: true
  validates :date_fin, presence: true
  validates :utilisateurs_id, presence: true
  validates :placeparkings_id, presence: true
end