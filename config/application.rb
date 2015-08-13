require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fotobook
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)

    # Due to alternative solution, dont use this anymore
    # Thread.new {
    #   require 'imgur-api'
    #   loop do
    #     ImgurApi.refreshTokens
    #     sleep 3300 #55 minutes
    #   end
    # }
    config.active_record.raise_in_transactional_callbacks = true
  end
end
