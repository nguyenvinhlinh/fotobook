class Tag < ActiveRecord::Base
  has_and_belongs_to_many :pictures
  accepts_nested_attributes_for :pictures
  validates :tag,
            presence: true,
            uniqueness: true,
            length: {
              minimum: 2,
              maximum: 15,
              too_short: "%{count} character is inputed 2 -> 15",
              too_long: "%{count} character is inputed 2 -> 15"
            }

  # Find a list of tags based on the picture_id
  # Params:
  # +picture_id+: an integer which is picture id
  # Return:
  # +tag_array+: it return an ActiveRecord instance
  def self.searchTagsByPicture(picture_id)
    raise ArgumentError, "The picture_id should be an integer." unless picture_id.is_a? Integer
    tag_array = Tag.joins(:pictures).where("pictures.id = #{picture_id}")
  end
end
