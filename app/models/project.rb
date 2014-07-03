class Project < ActiveRecord::Base
  has_many :tickets, dependent: :delete_all
  has_many :permissions, as: :thing
  
  scope :viewable_by, ->(user) do
    joins(:permissions).where(permissions: {action: "view", user: user})
  end
  
  validates :name, presence: true
end
