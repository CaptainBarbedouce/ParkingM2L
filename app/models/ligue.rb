class Ligue < ActiveRecord::Base
  has_many :utilisateurs
  
  validates :libel, presence: true, length: { maximum: 50 }
end