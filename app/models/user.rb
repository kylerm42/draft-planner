class User < ActiveRecord::Base
  # Include default devise modules, sans :confirmable, :omniauthable
  devise  :database_authenticatable, :registerable, :recoverable,
          :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  # Associations
  has_many :collections
  has_many :sheets, through: :collection
end
