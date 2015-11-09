class Company < ActiveRecord::Base
  has_many :projects, dependent: :destroy
  has_many :company_users, dependent: :destroy
  has_many :users, through: :company_users

  mount_uploader :image, ImageUploader

  validates :name, :description, presence: true
end
