class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  has_many :dashboard
  has_many :datafile

  has_secure_password
end
