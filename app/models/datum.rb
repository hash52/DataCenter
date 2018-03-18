class Datum < ApplicationRecord
  validates :datafile_id, presence: true
  validates :index, presence: true
  validates :key, presence: true
  validates :value, presence: true

  belongs_to :datafile
end
