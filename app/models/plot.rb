class Plot < ApplicationRecord
  validates :datafile_id, presence: true
  validates :title, presence: true
  validates :plot_type, presence: true
  validates :x_column, presence: true
  validates :y_column, presence: true

  belongs_to :datafile
end
