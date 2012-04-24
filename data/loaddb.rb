require 'rubygems'
require 'flickraw'
require 'awesome_print'
require 'data_mapper'
require './photo.rb'

DataMapper::Logger.new($stdout, :debug)
DataMapper::setup(:default,ENV['DATABASE_URL'])
DataMapper.finalize

FlickRaw.api_key=ENV['FLICKR_API']
FlickRaw.shared_secret=ENV['FLICKR_SECRET']

def getUrl(p) 
  if (p.respond_to?("url_l"))
    return p.url_l
  elsif (p.respond_to?("url_z"))
    return p.url_z
  elsif (p.respond_to?("url_m"))
    return p.url_m
  elsif (p.respond_to?("url_s"))
    return p.url_s
  end
  ''
end

(1..7).each do |page|
  photos = flickr.photos.search :page => page, :group_id => '95553424@N00', :has_geo => '1' , :extras =>'description,url_l,url_m,url_s,url_z,geo', :per_page => 500, :format => 'json', :nojsoncallback => 1

  photos.each do |p|
    url = getUrl(p)
    ap p
    # photo = Photo.first_or_create(
    #                  :photo_id => p.id,
    #                  :title => p.title,
    #                  :description => p.description,
    #                  :url => url,
    #                  :latitude => p.latitude,
    #                  :longitude => p.longitude
    #                )
  end     
end