class Picture < ActiveRecord::Base
  def self.search(term)
    if term
      self.where("tags LIKE ?", "%#{term}%")
    else
      self.all
    end
  end
  
end
