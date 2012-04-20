class Photo
    include DataMapper::Resource
    storage_names[:default] = :photos

    property :id,             Serial, :field => 'id'
    property :latitude,       Float
    property :longitude,      Float
end