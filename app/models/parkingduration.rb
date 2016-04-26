class Parkingduration < ActiveRecord::Base
  validates :maxduration, presence: true
end
