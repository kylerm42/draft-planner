class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules, sans :confirmable, :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
          :rememberable, :trackable, :validatable


  # Associations
  has_many :collections
  has_many :sheets, through: :collection
end
