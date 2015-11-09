class Project < ActiveRecord::Base
  belongs_to :company
  belongs_to :user

  validates :name, :description, :cpu, :ram, :hdd, presence: true

  include AASM

  aasm do
    state :unconfirmed, :initial => true
    state :confirmed
    state :canceled

    event :confirm do
      transitions :from => :unconfirmed, :to => :confirmed
    end

    event :unconfirm do
      transitions :from => :confirmed, :to => :unconfirmed
    end

    event :refuse do
      transitions :from => [:confirmed, :unconfirmed], :to => :canceled
    end
  end

end
