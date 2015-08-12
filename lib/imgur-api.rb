require 'net/http'
require 'json'
module ImgurApi
  CLIENT_ID = "0a684f8f62db86a"
  CLIENT_SECRET = "eaa9155d805be14fcd4c05c68c61cdf6b5d38845"
  AUTHORIZATION_CODE = "5020ce661e82dac69403285d1f71db83e0daaf8e"
  $Access_Token = ""
  $Refresh_Token = ""

  def initTokens
    uri = URI("https://api.imgur.com/oauth2/token")    
    result = Net::HTTP.post_form(uri, :client_id => CLIENT_ID,
                                 :client_secret => CLIENT_SECRET,
                                 :grant_type => "authorization_code",
                                 :code => AUTHORIZATION_CODE)
    result = Json.parse(result)
    $Access_Token = result['access_token']
    $Refresh_Token = result['refresh_token']
  end
  
  def refreshTokens
    uri = URI("https://api.imgur.com/oauth2/token")
    result = Net::HTTP.post_form(uri, :refresh_token => $Refresh_Token,
                                 :client_id => CLIENT_ID,
                                 :client_secret => CLIENT_SECRET,
                                 :grant_type => "authorization_code"
                                )
    result = Json.parse(result)
    $Access_Token = result['access_token']
    $Refresh_Token = result['refresh_token']
  end
end
