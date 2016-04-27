class Parkingduration < ActiveRecord::Base
  validates :maxduration, presence: true, numericality: true
end
