require "bundler"
Bundler.require

class App < Sinatra::Base
  set :sprockets,     Sprockets::Environment.new(root)
  set :precompile,    [ /\w+\.(?!js|css).+/, /application.(css|js)$/ ]
  set :assets_prefix, "/assets"
  set :digest_assets, false
  set(:assets_path)   { File.join public_folder, assets_prefix }

  configure do
    # Setup Sprockets
    sprockets.append_path File.join(root, "assets", "stylesheets")
    sprockets.append_path File.join(root, "assets", "javascripts")
    sprockets.append_path File.join(root, "assets", "images")

    # Configure Sprockets::Helpers (if necessary)
    Sprockets::Helpers.configure do |config|
      config.environment = sprockets
      config.prefix      = assets_prefix
      config.digest      = digest_assets
      config.public_path = public_folder
    end
  end

  helpers do
    include Sprockets::Helpers

    # Alternative method for telling Sprockets::Helpers which
    # Sprockets environment to use.
    # def assets_environment
    #   settings.sprockets
    # end
  end

  get "/" do
    erb :index
  end
end