class User < ApplicationRecord
  # Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable and :omniauthable,
  # :validatable, :recoverable
  devise :database_authenticatable, :rememberable, :trackable
end
