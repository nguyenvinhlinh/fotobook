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
end
