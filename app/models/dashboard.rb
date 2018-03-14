class Dashboard < ApplicationRecord
  validates :user_id, presence: true
  validates :name, presence: true
  
  has_many :datafiles

  belongs_to :user

end
