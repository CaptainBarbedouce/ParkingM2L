class Placeparking < ActiveRecord::Base
  has_many :historiques
  
  validates :libel, presence: true, length: { maximum: 2 }
  #validates :occupied, presence: true
end
