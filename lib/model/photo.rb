class Photo
    include DataMapper::Resource
    storage_names[:default] = :photos

    property :id,             Serial, :field => 'id'
    property :photo_id,       Text
    property :title,          Text
    property :description,    Text
    property :url,            Text    
    property :latitude,       Float
    property :longitude,      Float
    
end