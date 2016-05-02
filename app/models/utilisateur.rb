class Utilisateur < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  
  belongs_to :ligue, :class_name => "Ligue", :foreign_key => "ligues_id"
  has_many :historiques

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]{2,4}+\z/i

  validates :nom, presence: true, length: { maximum: 25 }
  validates :prenom, presence: true, length: { maximum: 25 }
  validates :adresse, length: { maximum: 50 }
  validates :ville, length: { maximum: 50 }
  validates :tel, presence: true, length: { is: 10 }
  validates :demande_reservation, default: false, presence: false
  validates :reservation_automatique, default: false, presence: false
  validates :admin, default: false
  validates :email, uniqueness: { case_sensitive: true } , presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :encrypted_password, presence: true
  validates :ligues_id, presence: true

  def to_s
    nom + ' ' + prenom
  end
end
