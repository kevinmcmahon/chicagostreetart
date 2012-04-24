require 'rubygems'
require 'data_mapper'

module ArtFinder  
  def self.find(lat,lng,numberOfResults)
    sql = 
    "SELECT 
    ROUND(CAST (ST_Distance(ST_Transform(ST_GeomFromText('POINT(#{lng} #{lat})', 4326),900913),ST_Transform(photos.geom,900913)) / 1609 AS numeric),2) AS dist,
    photos.id AS id,
    photos.photo_id AS photo_id,
    photos.title AS title,
    photos.description AS description,
    photos.url AS url,
    photos.latitude,
    photos.longitude
    FROM photos 
    ORDER BY dist ASC
    LIMIT #{numberOfResults};"

    DataMapper.repository(:default).adapter.select sql
  end
end