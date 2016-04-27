class Historique < ActiveRecord::Base
  belongs_to :utilisateur, class_name: "Utilisateur", :foreign_key => "utilisateurs_id"
  belongs_to :placeparking, class_name: "Placeparking", :foreign_key => "placeparkings_id"

  validates :date_debut, presence: true
  validates :date_fin, presence: true
end
