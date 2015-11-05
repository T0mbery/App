class User < ActiveRecord::Base

  has_many :projects
  has_many :company_users
  has_many :companies, through: :company_users

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
