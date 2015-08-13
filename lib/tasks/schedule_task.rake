namespace :schedule_task do
  desc "Refresh tokens of ImgurAPI"
  task :refresh_token => :environment do
    require'imgur-api'
    ImgurApi.refreshTokens
    p "refreshed tokens "
  end
end
