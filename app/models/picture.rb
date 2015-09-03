class Picture < ActiveRecord::Base
  has_and_belongs_to_many :tags, class_name: "Tag", join_table: "pictures_tags",
                          foreign_key: "picture_id",
                          association_foreign_key: "tag_id"
  validates :url, presence: true
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  
  # Search pictures by tags
  # Params:
  # +tag_array+ : an array of tag, empty element, duplicate, nil  will be
  # ignored
  # Return: An array of picture < ActiveRecord
  def self.searchByTagArray(tag_array)
    tag_array = tag_array.compact.uniq - [nil, ""]
    return nil if tag_array.empty?
    tag_array = tag_array.map do
      |atag|
      _like_query = "tags.tag LIKE '%#{atag}%'"
    end
    Picture.joins(:tags).where("%s" % tag_array.join(' OR '))
  end
end
