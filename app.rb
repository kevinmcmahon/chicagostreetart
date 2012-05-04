require 'rubygems'
require 'sinatra'
require 'haml'
require 'data_mapper'
require 'geocoder'
require 'awesome_print'

# Helpers

Dir["lib/**/*.rb"].each {|f| require "./#{f}"}

# Set Sinatra variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, 'views'
set :public_folder, 'public'
set :haml, {:format => :html5} # default Haml format is :xhtml

#DataMapper::Logger.new($stdout, :debug)
DataMapper::setup(:default, ENV['DATABASE_URL'] || "postgres://localhost:5432/chicago_db")

# Allow rendering of partials. See: https://gist.github.com/119874
helpers Sinatra::Partials

configure do
  # Default Haml format is :xhtml
  set :haml, { :format => :html5 }  
end

configure :production do
  set :haml, { :ugly => true }
end

#
# Helpers
#
helpers do
  include Rack::Utils
  alias_method :h, :escape_html
  def create_markers(array)
      js = "var markers = [\n"
      array.each do |i|
        js << "{ lat: #{i['latitude']}, lng: #{i.longitude}, name: '#{i.title}', url: '#{i.url}'},\n"
      end
      js << "];\n"
      js
    end
end

#
# Routes
#

not_found do
  redirect '/404.html'
end

get '/' do
  haml :index, :layout => :'layouts/application'
end

get '/about' do
  haml :about, :layout => :'layouts/application'
end

get '/findart' do
  @lat = 0.0
  @lng = 0.0
  if(!params['lat'].nil? && !params['lng'].nil?)
    @lat = params['lat']
    @lng = params['lng']
  elsif (!params['address'].nil?)
    result = Geocoder.search(params['address'])
    ap result
    @lat = result[0].latitude
    @lng = result[0].longitude
  end

  @photos = ArtFinder.find(@lat,@lng,10)
  haml :artlist, :layout => :'layouts/map'
end

get '/photo/:id?' do
  @photo = Photo.get(params[:id])
  haml :artdetail, :layout => :'layouts/mapdetail'
end