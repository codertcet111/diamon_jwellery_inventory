class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:username]

  attr_accessor :provide, :uid, :email, :password, :password_confirmation, :remember_me, :username
  validates_presence_of :username

  rails_admin do
    visible false
  end

end
