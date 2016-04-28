class Ligue < ActiveRecord::Base
  has_many :utilisateur
  
  validates :libel, presence: true, length: { maximum: 50 }
  def to_s
    libel
  end
end
