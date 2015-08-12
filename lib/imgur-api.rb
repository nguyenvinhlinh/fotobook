require 'net/http'
module ImgurApi
  CLIENT_ID = "0a684f8f62db86a"
  CLIENT_SECRET = "eaa9155d805be14fcd4c05c68c61cdf6b5d38845"
  AUTHORIZATION_CODE = "5020ce661e82dac69403285d1f71db83e0daaf8e"
  ACCESS_TOKEN = ""
  REFRESH_TOKEN = ""
  
  def getToken
    uri = URI("https://api.imgur.com/oauth2/token")    
    result = NET::HTTP.post_form(uri, client_id => CLIENT_ID,
                                 client_secret => CLIENT_SECRET,
                                 grant_type => "authorization_code",
                                 code =>
                                 "5020ce661e82dac69403285d1f71db83e0daaf8e")
    
    
  end
  
  
end
