require 'sinatra'
require "bugsnag"
require 'sprockets'
require 'sprockets-helpers'

class App < Sinatra::Base
  set :sprockets, Sprockets::Environment.new(root)
  set :assets_prefix, '/assets'
  set :digest_assets, false

  configure do
    # Setup Sprockets
    sprockets.append_path File.join(root, 'assets', 'stylesheets')
    sprockets.append_path File.join(root, 'assets', 'javascripts')
    sprockets.append_path File.join(root, 'assets', 'images')

    # Configure Sprockets::Helpers (if necessary)
    Sprockets::Helpers.configure do |config|
      config.environment = sprockets
      config.prefix      = assets_prefix
      config.digest      = digest_assets
      config.public_path = public_folder

      # Force to debug mode in development mode
      # Debug mode automatically sets
      # expand = true, digest = false, manifest = false
      config.debug       = true if development?
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

  get '/' do
    erb :index
  end
end

map App.assets_prefix do
  run App.sprockets
end

map "/" do
  run App
end

Bugsnag.configure do |config|
  config.api_key = "47f776f9f473d8cece6be6298e6d86bc"
end

set :raise_errors, true

use Bugsnag::Rack

#
get '/hola' do
  
nombres_completos 100,0
  unless params[:nombre]
    "Hola Mundo"
  else 
    "Hola #{params[:nombre]}" #imprimo parámetros
  end
 
  @nombre = "Sebastián"

  erb :index
end

get '/:nombre' do #recibo parámetros
  "Hola #{params[:nombre]}" #imprimo parámetros
end

post '/nuevo/objeto' do
  "Hemos creado un nuevo objeto con el verbo #{params[:verbo]}"
end


def nombres_completos nombre,apellido
  nombre /apellido 
end
