class Picture < ActiveRecord::Base
  def self.search(term)
    if term
      find(:all, :condition => ['tags LIKE ? ', "%#{term}%"])
    else
      find(:all)
    end
    
  end
end
