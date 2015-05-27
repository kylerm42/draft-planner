class User < ActiveRecord::Base
  # Include default devise modules, sans :confirmable
  devise :database_authenticatable, :registerable, :recoverable,
          :rememberable, :trackable, :validatable, :omniauthable

  include DeviseTokenAuth::Concerns::User
end
