class Ticket < ActiveRecord::Base
  attr_accessor :tag_names
  
  belongs_to :project
  belongs_to :state
  belongs_to :user
  has_many :assets
  has_many :comments
  accepts_nested_attributes_for :assets
  has_and_belongs_to_many :tags
  
  before_save :associate_tags
  
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  
  def self.search(query)
    query
      .split(" ")
      .collect do |query|
        query.split(":")
      end.inject(self) do |klass, (name, q)|
        plural_name = name.pluralize.to_sym
        association = klass.reflect_on_association(plural_name)
        association_table = association.klass.arel_table

        if [:has_and_belongs_to_many, :belongs_to].include?(association.macro)
          joins(plural_name).where(association_table["name"].eq(q))
        else
          all
        end
      end
  end
  
  private
  
  def associate_tags
    if self.tag_names
      tag_names.split(" ").each do |name|
        self.tags << Tag.find_or_create_by(name: name)
      end
    end
  end
  
end
