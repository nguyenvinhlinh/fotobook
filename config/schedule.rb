set :environment, "production"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every 1.minutes do
  rake "schedule_task:refresh_token"
end
