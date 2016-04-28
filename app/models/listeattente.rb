class Listeattente < ActiveRecord::Base
  belongs_to :utilisateur, :class_name => "Utilisateur", :foreign_key => "utilisateurs_id"
  
  validates :numPosition, presence: true, length: { maximum: 3 }
  validates :duration, presence: true, length: { is: 1 }
  validates :utilisateurs_id, presence: true
end
