class Project < ActiveRecord::Base
  belongs_to :company
  belongs_to :user

  validates :name, :description, presence: true

end
