class Ticket < ActiveRecord::Base
  attr_accessor :tag_names
  
  belongs_to :project
  belongs_to :state
  belongs_to :user
  has_many :assets
  has_many :comments
  accepts_nested_attributes_for :assets
  has_and_belongs_to_many :tags
  
  before_create :associate_tags
  
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  
  private
  
  def associate_tags
    if tag_names
      tag_names.split(" ").each do |name|
        self.tags << Tag.find_or_create_by(name: name)
      end
    end
  end
end
