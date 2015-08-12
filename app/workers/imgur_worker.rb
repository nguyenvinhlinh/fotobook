require 'imgur-api'
class ImgurWorker
  include Sidekiq::Worker
  include ImgurApi
  REFREST_TIME = 45 # 45 minutes
  def perform
    while(true)
      sleep 45*60
      p "running #{Time.now}"
      refreshTokens
    end
  end
end
