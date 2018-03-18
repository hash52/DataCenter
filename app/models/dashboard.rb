class Dashboard < ApplicationRecord
  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: true
  
  has_many :plot

  belongs_to :user

end
