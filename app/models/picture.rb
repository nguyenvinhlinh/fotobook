class Picture < ActiveRecord::Base
  has_and_belongs_to_many :tags, class_name: "Tag", join_table: "pictures_tags",
                          foreign_key: "picture_id",
                          association_foreign_key: "tag_id"
  validates :url, presence: true


  # Search pictures by tags
  # Params:
  # +tag_array+ : an array of tag, empty element, duplicate, nil  will be ignored
  # Examples:
  # tag_array = ['th', 'de', 'earth']
  def self.searchPictureByTagArray(tag_array)
    tag_array = tag_array.compact.unique.delete ''
    return nil if tag_array.empty?
    tag_array = tag_array.map {
      |atag|
      like_query = "tags.tag LIKE '%#{atag}%'"
    }
    Picture.joins(:tags).where("%s" % tag_array.join(' OR '))
  end
end
