class Picture < ActiveRecord::Base
  has_and_belongs_to_many :tags
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  validates :url, presence: true

  
  def self.searchPictureByTags(tag_array)
    pictures = Picture.joins(:tags).where("tags.tag = #{tag_array.join(',')}")
    pictures
  end
  def self.searchPictureByTagsWildCard(tag_array)
    
  end
end
