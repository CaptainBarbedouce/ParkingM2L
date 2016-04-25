class Placeparking < ActiveRecord::Base
  validates :libel, presence: true, length: { maximum: 2 }
  validates :occupied, presence: true
end
