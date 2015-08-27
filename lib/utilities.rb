module Utilities

  # Detach a string into an array of tags. It strips spaces, duplicate item
  # For example "a,xc,  ,1, 2 ,a" => [a,xc,1,2]
  # Params:
  # +tags_string: a string of tag which separated by commas
  # Return: an array of string 
  def stringToArray(a_string)
    _string_array = a_string.split(',').compact.collect(&:strip).uniq
  end
end
