class ImgurWorker
  include Sidekiq::Worker
  def perform (name, count)
    p "#{name}, #{count} Hello, I am ImgurWorker, I will refresh token after each 45 mins"
  end
end
