class Historique < ActiveRecord::Base
  belongs_to :utilisateur
  belongs_to :placeparking
  validates :date_debut, presence: true
  validates :date_fin, presence: true
end
