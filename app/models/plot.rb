class Plot < ApplicationRecord
  validates :title, presence: true
  validates :type, presence: true
  validates :x_column, presence: true
  validates :y_column, presence: true

  belongs_to :dashboard
end
