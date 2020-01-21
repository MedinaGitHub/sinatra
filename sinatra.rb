require "bundler"
require_relative "./src/filter"
require_relative "./src/tag"

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
  end

  get "/" do
 
    liquid_common = "<h1 style='color:red'> Buena {{name}} </h1>"
    filter_common = "<br> {{ '*soy un strong*' | textilize }}"
    filter_common_me = "<br> {{ '5' | same_multi }}"
    tag_common = "<br> soy un num ramdom=> {% random 5 %}"
    tag_assing = "<br> multiplicaremos = {% multiply 5 %}"
    tag_block = "<br> {% randomBlock 5 %} you have drawn number ^^^, lucky you! {% endrandomBlock %}"
    tag_two_val = "<br> dos valores al patametro son :  a * b = {% lo_que_sea a:10 , b:20 %} "



    @liquid = Liquid::Template
    @liquid.register_filter(TextFilter)
    @liquid.register_tag('random', Tag::Random)
    @liquid.register_tag('lo_que_sea', Tag::TwoValMult)
    @liquid.register_tag('multiply', Tag::AssignmentsMultiply)
    @liquid.register_tag('randomBlock', Tag::BlocksRandom)

    @template = @liquid.parse(liquid_common + filter_common + filter_common_me + tag_common + tag_assing + tag_block  +tag_two_val) # Parses and compiles the template

    @template.assigns["multiply_by"] = 10
    @template.render('name' => 'tobi')    
    @wrapper = @template.render({}, :filters => [TextFilter])      
    erb :index
  end
end