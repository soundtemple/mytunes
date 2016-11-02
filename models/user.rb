class User < ActiveRecord::Base
  has_secure_password
  has_many :songs
  # has_many :playlists

  validates :username, :password, :email, presence: true
  validates :username, length: { minimum: 3 }
  validates :username, length: { maximum: 100 }
  validates :email, length: { minimum: 3 }
  validates :email, length: { maximum: 100 }
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :password, length: { minimum: 3 }
  validates :password, length: { maximum: 50 }
  # validates :password, confirmation: true
  # validates :password_confirmation, presence: true
end
