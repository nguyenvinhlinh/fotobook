require 'net/http'
require 'json'
module ImgurApi
  CLIENT_ID = "0a684f8f62db86a"
  CLIENT_SECRET = "eaa9155d805be14fcd4c05c68c61cdf6b5d38845"
  $Access_Token = "5446c6c3d4447eb128ef042475f3876350001a37"
  $Refresh_Token = "e28a984648e3e8af55669fae110e253079a421b4"
  def self.refreshTokens
    uri = URI("https://api.imgur.com/oauth2/token")
    result = Net::HTTP.post_form(uri, :refresh_token => $Refresh_Token,
                                 :client_id => CLIENT_ID,
                                 :client_secret => CLIENT_SECRET,
                                 :grant_type => "refresh_token"
                                )
    result = JSON.parse(result.body)
    $Access_Token = result['access_token']
    $Refresh_Token = result['refresh_token']
    p "####### DEBUG #######"
    p "result: #{result}"
    p "$Access_Token: #{$Access_Token}"
    p "$Refresh_Token: #{$Refresh_Token}"
    p "---------"
    p getAccessToken
    p getRefreshToken
    p "##### debug end #####" 
  end

    
  def self.getAccessToken
    $Access_Token
  end
  
  def self.getRefreshToken
    $Refresh_Token
  end

end
