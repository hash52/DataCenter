class Datafile < ApplicationRecord
  validates :user_id, presence: true
  validates :name, presence: true
  validates :datafile, presence: true

  mount_uploader :datafile, DataFileUploader

  belongs_to :user
  has_many :datum
  has_many :plot
end
