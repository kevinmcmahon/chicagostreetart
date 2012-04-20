require 'rubygems'
require 'flickraw'
require 'awesome_print'


FlickRaw.api_key=ENV['FLICKR_API']
FlickRaw.shared_secret=ENV['FLICKR_SECRET']

info = flickr.photos.search :page => '2', :has_geo => '1' , :extras =>'description,url_l,geo', :per_page => 5, :format => 'json', :nojsoncallback => 1
ap info
