require 'imgur-api'
class ImgurWorker
  include Sidekiq::Worker
  include ImgurApi
  REFREST_TIME = 45 # 45 minutes
  def perform
    p "running"
    refreshTokens
  end
end
