# { 
#   "id": "4689283004", 
#   "owner": "70033871@N00", 
#   "secret": "a16c6c604f", 
#   "server": "4069", 
#   "farm": 5, 
#   "title": "Chicago Graf (7)", 
#   "ispublic": 1,
#   "isfriend": 0, 
#   "isfamily": 0, 
#   "description": { "_content": "" },
#   "url_l": "http:\/\/farm5.staticflickr.com\/4069\/4689283004_a16c6c604f_b.jpg", 
#   "height_l": "627", 
#   "width_l": "1024" 
# }
  
require 'rubygems'
require 'windy'
require 'awesome_print'
require 'data_mapper'
require './bike_rack'

DataMapper::Logger.new($stdout, :debug)
DataMapper::setup(:default,ENV['DATABASE_URL'])
DataMapper.finalize

dataset = 'cbyb-69xx'

Windy.app_token = 'LNK07KanQSRmYhO1SHHA3Kgq9'
view = Windy.views.find_by_id(dataset)

view.rows.each do |r|
  rack = BikeRack.first_or_create(
            :rackid => r.rackid, 
            :address => r.address,
            :ward => r.ward,
            :community_area => r.community_area,
            :community_name => r.community_name,
            :totinstall => r.totinstall,
            :latitude => r.latitude,
            :longitude => r.longitude,
            :historical => r.historical
          )
end