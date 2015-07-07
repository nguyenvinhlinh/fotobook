class Picture < ActiveRecord::Base
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags
  validates :url, presence: true 
  ##This function will take a string
  def self.search(term)
    if term != "" && term.nil? == false
      term_array = term.split(",")
      for i in 0...term_array.size
        term_array[i] = term_array[i].strip()
      end      
      sql_statement = "SELECT * FROM pictures WHERE tags LIKE "
      if term_array.size == 1
        sql_statement += "\'%" + term_array[0] + "%\' "
      else
        sql_statement += "\'%" + term_array[0] + "%\' "
        for index in 1...term_array.size
          #term_array[index] = term_array[index].strip
          if term_array[index] != ""
            sql_statement += "OR tags LIKE \'%" + term_array[index] + "%\' "
          end
        end
      end
      self.find_by_sql(sql_statement)
    else
      self.all
    end
  end
end
