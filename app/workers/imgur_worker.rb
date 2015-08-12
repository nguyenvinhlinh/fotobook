class ImgurWorker
  include Sidekiq::Worker
  REFREST_TIME = 45 # 45 minutes
  def perform
    Imgur::initTokens
    while (true)
      ImgurApi::refreshTokens
      sleep 45 * 60
    end
  end
end
