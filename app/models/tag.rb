class Tag < ActiveRecord::Base
  has_and_belongs_to_many :pictures
  accepts_nested_attributes_for :pictures
  validates :tag,
            absence: true,
            length: {
              minium: 2,
              maximum: 10
            }
end
