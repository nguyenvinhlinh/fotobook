class Tag < ActiveRecord::Base
  has_and_belongs_to_many :pictures
  accepts_nested_attributes_for :pictures
  validates :tag,
            presence: true,
            uniqueness: true,
            length: {
              minium: 2,
              maximum: 10,
              too_short: "%{count} character is inputed 2 -> 10",
              too_long: "%{count} character is inputed 2 -> 10"
            }

  def self.find(tag_name)
    _tag = Tag.find_by(tag: tag_name)
  end
  
  def self.existTagName?(tag_name)
    _tag = find(tag_name)
    if _tag != nil
      return _tag
    else
      return false
    end
  end
end
