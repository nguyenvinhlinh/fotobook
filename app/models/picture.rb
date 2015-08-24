class Picture < ActiveRecord::Base
  has_and_belongs_to_many :tags
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  validates :url, presence: true
  
end
