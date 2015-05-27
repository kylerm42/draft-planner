class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules, sans :confirmable
  devise :database_authenticatable, :registerable, :recoverable,
          :rememberable, :trackable, :validatable, :omniauthable


  # Associations
  has_many :collections
  has_many :sheets, through: :collection
end
